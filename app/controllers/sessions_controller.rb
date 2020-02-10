# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  # Inherit other methods from Devise Sessions controller

  def after_sign_in_path_for(_resource_or_scope)
    dashboard_path
  end
end
