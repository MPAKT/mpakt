# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :blogging_allowed, except: %i[index show]

  def index
    @blogs = if current_user&.admin?
               Blog.all
             else
               Blog.live
             end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.create(blog_params)
    redirect_to blog_path(@blog)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to blog_path(@blog)
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private

  def blogging_allowed
    return if current_user&.admin?

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def blog_params
    params.require(:blog).permit(:title, :summary, :description, :image, :publish)
  end
end
