class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.customer_id = current_customer.id
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:customer_id, :post_id, :comment)
  end
end
