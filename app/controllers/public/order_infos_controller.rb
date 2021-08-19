class Public::OrderInfosController < ApplicationController
  before_action :move_to_signed_in

  def new
    @order_info = OrderInfo.new()
  end

  def index
  end

  def show
  end

  def create
  end

  def confirm
  end

  def complete
  end

  private
  def order_ifo_params
    params.require(:order_info).permit(:postage, :total_payment, :payment_method, :order_status, :postal_code, :address, :name)
  
  def move_to_signed_in
    unless customer_signed_in?
      redirect_to  '/customers/sign_in'
    end
  end
end
