class Admin::OrderProductsController < ApplicationController
  def update
    @order_info = OrderInfo.find(params[:order_id])
    @order_product = OrderProduct.find(params[:id])
    if @order_product.update(order_product_params)
      redirect_to admin_order_info(order_info)
    else
      render template: "order_infos/show"
    end
  end

  private
  def order_product_params
    params.require(:order_product).permit(:product_status)
  end
end
