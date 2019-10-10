# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :changes_allowed, except: %i[index show]

  def index; end

  def show; end

  def create; end

  def update; end

  def destroy; end

  private

  def changes_allowed
    return true if user.admin?
    false
  end

  def blogs_params
    params.require(:blog).permit(:title, :summary, :description, :image)
  end
end
