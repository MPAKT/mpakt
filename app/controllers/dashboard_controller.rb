# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    @forum_post = Thredded::Post.order(created_at: :desc).first
  end
end
