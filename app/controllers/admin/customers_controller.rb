class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
