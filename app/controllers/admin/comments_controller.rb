class Admin::CommentsController < Admin::Base
  def destroy
    Comment.find_by(id: params[:id], product_id: params[:product_id], customer_id: params[:customer_id]).destroy
    redirect_to admin_product_path(params[:product_id])
  end

end
