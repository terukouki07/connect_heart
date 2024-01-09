class Public::CustomersController < ApplicationController
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
  
  private
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
