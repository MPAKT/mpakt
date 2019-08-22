# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :changes_allowed

  def index
    @users = User.all.order(last_sign_in_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to users_path, notice: t(".success", email: @user.email)
  end

  def changes_allowed
    return if UserPolicy.manage?(current_user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def user_params
    params.require(:user).permit(:admin, :volunteer)
  end
end
