# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  before_action :changes_allowed

  def index
    @users = User.all.order(last_sign_in_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    if request.referer.ends_with?("users")
      redirect_to users_path, notice: t(".success", email: @user.email)
    else
      super
    end
  end

  def changes_allowed
    return if UserPolicy.manage?(current_user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def user_params
    params.require(:user).permit(:admin, :volunteer, :short_name, :password, :password_confirmation)
  end
end
