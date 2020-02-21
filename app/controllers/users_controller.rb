# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  before_action :changes_allowed, except: %i[new create]

  def index
    @users = User.all.order(last_sign_in_at: :desc)
  end

  def edit
    @profile = @user.profile || Profile.create(user_id: @user.id)
  end

  def update
    @user.profile.update_attributes(profile_params) if profile_params
    @profile = @user.profile

    # Devise will enforce providing the old password, so let's be nice, just make the update if the
    # user didn't try to change their password to a new one: also necessary for admin updates
    if user_params[:password].blank?
      @user.update_attributes(user_params)
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

  def changes_allowed
    @user = User.find(params[:id]) if params[:id]
    return if UserPolicy.manage?(current_user, @user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def user_params
    params.require(:user).permit(:admin, :volunteer, :short_name, :password, :password_confirmation, :current_password)
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
