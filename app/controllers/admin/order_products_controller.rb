class Admin::OrderProductsController < Admin::Base
  def update
    @order_product = OrderProduct.find(params[:id])
    @order_info = OrderInfo.find_by(id: @order_product.order_id)
    product_complete = true

    if @order_product.update(order_product_params)
      if @order_product.product_status = 2 && @order_info.order_status == 1 #製品が製作中かつ注文が入金確認
        @order_info.update(order_status: 2) #製作中
      end
      @order_info.order_products.each do |product|
        if product.product_status < 3 #製作完了
          product_complete = false
        end
      end
      if product_complete == true
        @order_info.update(order_status: 3) #発送準備中
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
