class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    #current_customerがしているいいねの情報を取り出し、その中にpost.idがあるか探す。あれば取得。なければ空。
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end
end
