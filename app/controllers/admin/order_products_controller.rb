class Admin::OrderProductsController < ApplicationController
  def update
    @order_product = OrderProduct.find(params[:id])
  end
end
