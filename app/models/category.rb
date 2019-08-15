# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :privilege

  enum subtype: %i[
    ability
    caste
    race
    gender
  ]
end
