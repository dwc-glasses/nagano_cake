class Public::OrderInfosController < Public::Base
  before_action :move_to_signed_in

  def new
    @order_info = OrderInfo.new
    @customer_addresses = Address.where(customer_id: current_customer.id)
  end

  def index
  end

  def show
  end

  def create
    @order_info = OrderInfo.new(order_ifo_params)
  end

  def confirm
    @order_info = order_ifo_params
    @postage = 800
  end

  def complete
  end

  private
  def order_ifo_params
    params.require(:order_info).permit(:postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name)
  end

  def move_to_signed_in
    unless customer_signed_in?
      redirect_to  '/customers/sign_in'
    end
  end
end
