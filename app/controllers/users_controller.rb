# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :changes_allowed

  def index
    @users = User.all.order(:last_sign_in_at)
  end

  def changes_allowed
    return if UserPolicy.manage?(current_user)

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end
end
