class Public::SearchesController < ApplicationController
  def search
    #range=>formで選択されたモデル
    @range = params[:range]
    
    #word=>formで入力された検索ワード
    #search=>formで選択された検索方法
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
