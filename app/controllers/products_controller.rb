class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_category

  def index
    @products = Product.all
    @products = @products.sort_by{|c| c[:created_at]}
    @products = @products.reverse
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(product_params)
    @product = Category.find(params[:category_id])
  
    if @product.save
      redirect_to category_products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to category_product_path(@category, @product)
  end

  def destroy
    @product.destroy
    redirect_to category_products_path(@category, @product)
  end


  private

  def product_params
    params.require(:product).permit(:title, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end