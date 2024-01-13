# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  #サインイン後の遷移先(マイページ)
  def after_sign_in_path_for(resource)
    customer_path(current_customer.id)
  end

  #サインアウト後の遷移先(トップページ)
  def after_sign_out_for(resource)
    root_path
  end

  #ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    flash[:notice] = "ゲストユーザーとしてログインしました。"
    redirect_to root_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
