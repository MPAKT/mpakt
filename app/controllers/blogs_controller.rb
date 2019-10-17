# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :changes_allowed, except: %i[index show]

  def index
    @blogs = Blog.all
  end

  def new; end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.create(blog_params)
    redirect_to blogs_path
  end

  def update; end

  def destroy; end

  private

  def changes_allowed
    return true if current_user.admin?
    false
  end

  def blog_params
    params.require(:blog).permit(:title, :summary, :description, :image)
  end
end
