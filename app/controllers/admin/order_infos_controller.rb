class Admin::OrderInfosController < Admin::Base
  def index
    @order_infos = OrderInfo.all.page(params[:page]).per(10)

    @sales_today =          OrderInfo.scope_today.sum(:total_payment)
    @sales_a_day_ago =      OrderInfo.scope_a_day_ago.sum(:total_payment)
    @sales_two_days_ago =   OrderInfo.scope_two_days_ago.sum(:total_payment)
    @sales_three_days_ago = OrderInfo.scope_three_days_ago.sum(:total_payment)
    @sales_four_days_ago =  OrderInfo.scope_four_days_ago.sum(:total_payment)
    @sales_five_days_ago =  OrderInfo.scope_five_days_ago.sum(:total_payment)
    @sales_six_days_ago =   OrderInfo.scope_six_days_ago.sum(:total_payment)
  end

  def show
    @order_info = OrderInfo.find(params[:id])
  end

  def update
    @order_info = OrderInfo.find(params[:id])
    if @order_info.update(order_info_params)
      redirect_to admin_order_info_path(@order_info)
    else
      render :show
    end
  end

  private
  def order_info_params
    params.require(:order_info).permit(:order_status)
  end
end
