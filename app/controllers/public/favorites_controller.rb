class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(customer_id: current_customer.id, post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(customer_id: current_customer.id, post_id: @post.id)
    favorite.destroy
  end
end
