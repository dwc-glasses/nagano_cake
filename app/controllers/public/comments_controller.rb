class Public::CommentsController < Public::Base

  def create
    @comment = current_customer.comments.new(comment_params)
    if @comment.save
      redirect_to public_product_path(@comment.product_id)
    else
      @product = Product.find(@comment.product_id)
      @cart_product = CartProduct.new
      render "public/products/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :product_id)
  end
end
