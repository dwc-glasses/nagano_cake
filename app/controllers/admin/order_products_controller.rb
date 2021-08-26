class Admin::OrderProductsController < Admin::Base
  def update
    @order_product = OrderProduct.find(params[:id])
    @order_info = OrderInfo.find_by(id: @order_product.order_id)
    product_complete = true

    if @order_product.update(order_product_params)
      if @order_product.product_status = 2
        @order_info.update(order_status: 2)
      end
      @order_info.order_products.each do |product|
        if product.product_status < 3
          product_complete = false
        end
      end
      if product_complete == true
        @order_info.update(order_status: 3)
      end

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
