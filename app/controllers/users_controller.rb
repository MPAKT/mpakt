# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  before_action :changes_allowed, except: %i[new create show]
  before_action :read_allowed, only: %i[show]

  def index
    @users = User.all.order(last_sign_in_at: :desc)
  end

  def edit
    @profile = @user.profile || Profile.create(user_id: @user.id)
  end

  def update
    @user.profile.update_attributes(profile_params) if profile_params
    @profile = @user.profile

    if non_password_update
      redirect_to after_update_path_for(@user), notice: t(".success", email: @user.email)
    else
      super
    end
  end

  def new
    super
  end

  def create
    super
  end

  def show
    @user = User.find(params[:id])
  end

  def after_sign_up_path_for(*)
    dashboard_path
  end

  def after_update_path_for(resource)
    if request.referer.ends_with?("users")
      users_path
    else
      user_path(resource)
    end
  end

  private

  def non_password_update
    return false unless account_update_params[:password].blank?

    # Devise will enforce providing the old password, so be nice, make the update if the
    # user didn't try to change their password to a new one
    # Also needed for admin updates which don't have a password field to provide

    @user.update_attributes(non_password_params)
    true
  end

  def changes_allowed
    @user = User.find(params[:id]) if params[:id]
    return if UserPolicy.manage?(current_user, @user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def read_allowed
    return if current_user

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  # WARNING Use with care, non_password_params will allow you to bypass password requirements
  # Tried user clean_up_passwords instead, but it sets passwords to "", and does not delete them entirely
  def non_password_params
    params.require(:user).permit(:admin, :volunteer, :short_name)
  end

  def account_update_params
    params.require(:user).permit(
      :admin,
      :volunteer,
      :short_name,
      :current_password,
      :password,
      :password_confirmation
    )
  end

  def profile_params
    return unless params[:profile]

    params.require(:profile).permit(:description, :role, :facebook, :twitter, :instagram, :summary, :interests, :url)
  end
end
