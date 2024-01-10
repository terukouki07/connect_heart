class Public::SearchesController < ApplicationController

  def search
    #word=>formで入力された検索ワード, range=>formで選択されたモデル, search=>formで選択された検索方法
    @range = params[:range]

    if @range == "Customer"
      @records = Customer.looks(params[:search], params[:word])
    else
      @records = Post.looks(params[:search], params[:word])
    end
  end
end
