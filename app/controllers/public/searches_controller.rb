class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @records = Post.looks(params[:word])
  end
end
