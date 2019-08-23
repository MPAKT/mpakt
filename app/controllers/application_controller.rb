# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::RoutingError do |_exception|
    flash[:alert] = t("errors.messages.page_not_found")

    redirect_to root_url
  end

  protected

  #def after_sign_in_path_for(resource)
  #  root_path
  #end

  #def after_sign_up_path_for(resource)
  #  root_path
  #end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:short_name])
  end
end
