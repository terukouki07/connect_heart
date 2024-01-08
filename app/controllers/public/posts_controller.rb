class Public::PostsController < ApplicationController
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
    @posts = Post.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:notice] = "投稿の更新に失敗しました。"
      render :edit
    end
  end
  
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to posts_path
    else
      flash.now[:notice] = "投稿の削除に失敗しました。"
      render :show 
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :sex, :age, :body, :character, :status, :image, :customer_id, :genre_id)
  end
end
