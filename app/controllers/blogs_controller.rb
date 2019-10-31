# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :blogging_allowed, except: %i[index show]

  def index
    @blogs = if current_user&.admin?
               all_blogs
             else
               Blog.live.order(:title)
             end
  end

  def new; end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.create(blog_params)
    redirect_to blog_path(@blog), notice: t("success.create", name: @blog.title)
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to blog_path(@blog), notice: t("success.update", name: @blog.title)
  end

  def destroy
    @blog = Blog.find(params[:id])
    name = @blog.title
    @blog.destroy
    redirect_to blogs_path, notice: t("success.delete", name: name)
  end

  private

  def all_blogs
    Blog.live.order(:title) + Blog.where(publish: false).order(:title)
  end

  def blogging_allowed
    return if current_user&.admin?

    redirect_to root_url, notice: t("errors.messages.not_authorized")
  end

  def blog_params
    params.require(:blog).permit(:title, :summary, :description, :image, :publish)
  end
end
