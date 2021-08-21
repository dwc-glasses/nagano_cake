class Public::OrderInfosController < Public::Base
  before_action :move_to_signed_in

  def new
    @order_info = OrderInfo.new
    @customer_addresses = Address.where(customer_id: current_customer.id)
  end

  def index
    @order_infos = OrderInfo.where(customer_id: current_customer.id)
  end

  def show
    @order_info = OrderInfo.find(params[:id])
    @postage = 800
  end

  def create

    @order_info = current_customer.order_infos.new(order_info_params)
    if @order_info.save!
      cart_products = current_customer.cart_products
      cart_product_array = Array.new
      cart_products.each do |cart_product|
        product = cart_product.product
        cart_product_array << product.id
        cart_product_array << product.price*1.1
        cart_product_array << cart_product.quantity
        OrderProduct.create(order_id: @order_info.id, product_id: cart_product_array[0], price: cart_product_array[1], quantity: cart_product_array[2], product_status: 0)
        cart_product_array = Array.new
      end
      current_customer.cart_products.destroy_all
      redirect_to action: :complete
    else
      flash[:alert] = "エラーです"
      redirect_to public_cart_products
    end
  end

  def confirm
    @order_info = order_info_params
    @cart_products = current_customer.cart_products
    @postage = 800
  end

  def complete
  end

  private
  def order_info_params
    params.require(:order_info).permit(:postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name)
  end

  def move_to_signed_in
    unless customer_signed_in?
      redirect_to  '/customers/sign_in'
    end
  end
end