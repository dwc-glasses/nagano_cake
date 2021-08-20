class Admin::ProductsController < Admin::Base

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash.notice = "商品を追加しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "new"
    end

  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash.notice = "商品情報を更新しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "edit"
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :genre_id, :price, :sales_status, :image)
  end

end
