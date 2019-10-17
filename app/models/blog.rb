# frozen_string_literal: true

class Blog < ApplicationRecord
  validates :title, :summary, presence: true
end
