class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    #新着順かつページネーションも表示
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def post_params
    params.require(:post).permit(:name, :sex, :age, :body, :character, :status, :image, :user_id, :genre_id)
  end
end
