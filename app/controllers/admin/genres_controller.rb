class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "投稿しました。"
      redirect_to request.referer
    else
      @genres = Genre.all
      flash.now[:notice] = "投稿に失敗しました。"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "更新しました。"
      redirect_to admin_genres_path
    else
      flash.now[:notice] = "更新に失敗しました。"
      render :edit
    end
  end

  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
