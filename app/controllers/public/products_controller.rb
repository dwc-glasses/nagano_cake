class Public::ProductsController < ApplicationController
    
  def index
    @products = Product.all
    @cart_product = CartProduct.new
  end
  
  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
  end
  
end
