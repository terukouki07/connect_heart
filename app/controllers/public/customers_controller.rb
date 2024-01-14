class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit, :update]
  before_action :is_matching_customer, only: [:edit, :update, :favorite]

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

  #ゲストユーザーは編集画面へ遷移できないように制限
  def ensure_guest_customer
    customer = Customer.find(params[:id])
    if customer.email == "guest@example.com"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to root_path
    end
  end

  #他のユーザーの編集、いいね一覧画面への遷移を制限
  def is_matching_customer
    customer = Customer.find(params[:id])
    if customer.id != current_customer.id
      flash[:notice] = "他のユーザーのプライベートページへの遷移はできません。"
      redirect_to root_path
    end
  end

end
