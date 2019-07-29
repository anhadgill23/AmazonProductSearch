class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    # B002QYW8LW
    @product = Product.new(product_params)

    # make api call
    @scraper_data = Scraper.get_product_info(params[:product][:asin])

    @product.name = @scraper_data[:name]
    @product.category = @scraper_data[:category]
    @product.rank = @scraper_data[:rank]
    @product.dimensions = @scraper_data[:dimensions]

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Here is the product information.' }
        format.json { render :show, status: :created, location: @product }
      else
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
