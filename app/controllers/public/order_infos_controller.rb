class Public::OrderInfosController < Public::Base
  before_action :move_to_signed_in

  def new
    @order_info = OrderInfo.new
    @customer_addresses = Address.where(customer_id: current_customer.id)
  end

  def index
    @order_infos = Orderinfo.where(customer_id: current_customer.id)
  end

  def show
    @order_info = OrderInfo.find(params[:id])
  end

  def create
    # @order_info = OrderInfo.new(order_info_params)
    if current_customer.OrderInfo.create(order_info_params)
      redirect_to action: :complete
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
