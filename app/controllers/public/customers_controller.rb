class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  
  def index
    #新着順かつページネーションも表示
    @customers = Customer.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新しました"
      redirect_to customer_path(@customer.id)
    else
      flash.now[:notice] = "更新に失敗しました。"
      render :edit
    end
  end

  def favorite
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
  
  #
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to root_path 
    end
  end  
end
