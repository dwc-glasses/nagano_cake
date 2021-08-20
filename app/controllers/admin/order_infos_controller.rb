class Admin::OrderInfosController < Admin::Base
  def index
    @order_infos = OrderInfo.all
  end

  def show
    @order_info = OrderInfo.find(params[:id])
  end

  def update
    @order_info = OrderInfo.find(params[:id])
    if @order_info.update(order_info_params)
      redirect_to admin_order_info(order_info)
    else
      render :show
    end
  end

  private
  def order_info_params
    params.require(:order_info).permit(:order_status)
  end
end
