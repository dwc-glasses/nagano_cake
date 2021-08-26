class Public::ProductsController < Public::Base
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @products = Product.all
    @cart_product = CartProduct.new
  end

  def show
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
    @comment = Comment.new
  end

end
