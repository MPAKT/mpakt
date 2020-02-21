# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  before_action :changes_allowed, except: %i[new create]

  def index
    @users = User.all.order(last_sign_in_at: :desc)
  end

  def edit; end

  def update
    @user.update(user_params)

    redirect_path = request.referer.ends_with?("users") ? users_path : user_path(@user.id)
    redirect_to redirect_path, notice: t(".success", email: @user.email)
  end

  def new
    super
  end

  def create
    super
  end

  def after_sign_up_path_for(*)
    dashboard_path
  end

  private

  def changes_allowed
    @user = User.find(params[:id]) if params[:id]
    return if UserPolicy.manage?(current_user, @user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def user_params
    params.require(:user).permit(:admin, :volunteer, :short_name, :password, :password_confirmation)
  end
end
