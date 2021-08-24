module Public::CommentsHelper
  def have_you_already_comment?
    @have_already_comment = false
    if current_customer.comments.where(product_id: params[:id]).exists?
        @have_already_comment = true
    end
    return @have_already_comment
  end

  def have_you_ordered_product?
    @have_ordered_product = false
    current_customer.order_infos.each do |order|
      if order.order_products.where(product_id: params[:id]).exists?
        @have_ordered_product = true
      end
    end
    return @have_ordered_product
  end
end
