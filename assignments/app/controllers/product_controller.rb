class ProductController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit([:name, :price, :code, :description])
    @product = Product.new(product_params)
    @product.save
    render :show
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
    @num_products = @products.length
    render :index
  end
end
