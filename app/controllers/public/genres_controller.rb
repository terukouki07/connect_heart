class Public::GenresController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @genre = Genre.find(params[:id])
  end
end
