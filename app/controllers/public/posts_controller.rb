class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_post, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to posts_path
    else
      flash.now[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    #新着順かつページネーションも表示
    @posts = Post.order(created_at: :desc).page(params[:page]).per(6)
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      flash[:notice] = "更新しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:notice] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :sex, :age, :body, :character, :status, :image, :customer_id, :genre_id)
  end

  #他のユーザーの編集ページへの遷移を制限
  def is_matching_post
    post = Post.find(params[:id])
    if post.customer.id != current_customer.id
      flash[:notice] = "他のユーザーのプライベートページへの遷移はできません。"
      redirect_to root_path
    end
  end
  
end
