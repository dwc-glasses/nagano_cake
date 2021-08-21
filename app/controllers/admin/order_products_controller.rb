class Admin::OrderProductsController < Admin::Base
  def update
    @order_product = OrderProduct.find(params[:id])
    @order_info = OrderInfo.find_by(id: @order_product.order_id)
    if @order_product.update(order_product_params)
      redirect_to admin_order_info_path(@order_info)
    else
      render template: "order_infos/show"
    end
  end

  private
  def order_product_params
    params.require(:order_product).permit(:product_status)
  end
end
