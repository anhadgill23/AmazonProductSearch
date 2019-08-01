class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    # make api call
    @scraper_data = Scraper.get_product_info(params[:product][:asin])

    # error handling
    if @scraper_data.include? 'webpage not found'
      @product.errors.add(:asin, @scraper_data.parameterize.underscore.to_sym, message: @scraper_data)
    elsif @scraper_data.include? 'server error'
      @product.errors.add(:asin,@scraper_data.parameterize.underscore.to_sym, message: @scraper_data)
    end

    if @product.errors.empty?
      @product.name = @scraper_data[:name]
      @product.category = @scraper_data[:category]
      @product.rank = @scraper_data[:rank]
      @product.dimensions = @scraper_data[:dimensions]
      @product.save
      redirect_to @product, notice: 'Here is the product information.'
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end
end
