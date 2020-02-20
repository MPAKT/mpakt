# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @forum_post = Thredded::Post.order(created_at: :desc).first if current_user
  end
end
