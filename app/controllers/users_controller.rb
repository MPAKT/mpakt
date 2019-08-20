class UsersController < ApplicationController
  def index
    @users = User.all.order(:last_sign_in_at)
  end
end
