class Public::CartProductsController < ApplicationController

  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def create
    @cart_product = CartProduct.new(cart_product_params)

    if @cart_product.save
      flash[:notice] = "カートに商品を追加しました。"
      redirect_to action: "index"
    else
      flash[:alert] = "エラーです"
      redirect_back(fallback_location: root_path)
    end

  end

  def update
    @cart_product = CartProduct.find(params[:id])

    if @cart_product.update(cart_product_params)
      flash[:notice] = "カートの内容を更新しました。"
      redirect_to action: "index"
    else
      flash[:alert] = "エラーです"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    product_name = Product.find(@cart_product.product_id).name

    if @cart_product.destroy
      flash[:notice] = "#{product_name}をカートから削除しました。"
      redirect_to action: "index"
    else
      flash[:alert] = "エラーです"
      redirect_back(fallback_location: root_path)
    end
  end

  def delete_all
    @cart_products = CartProduct.where(customer_id: current_customer.id)
    if @cart_products.destroy_all
      flash[:notice] = "カートを空にしました。"
      redirect_to action: "index"
    else
      flash[:alert] = "エラーです"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def cart_product_params
    params.require(:cart_product).permit(:customer_id, :product_id, :quantity)
  end

end
