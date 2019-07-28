class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def show
  end

  def new
    @product = Product.new
  end

  def create
    # B002QYW8LW
    @product = Product.new(product_params)

    # make api call
    @product_info = Scraper.get_product_info(params[:product][:asin])

    @product.name = @product_info[:name]
    @product.category = @product_info[:category]
    @product.rank = @product_info[:rank]
    @product.dimensions = @product_info[:dimensions]

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

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:asin)
  end
end
