# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :privilege

  enum name: %i[
    gender
    race
    class
    ability
  ]
end
