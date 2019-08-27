# frozen_string_literal: true

class Privilege < ApplicationRecord
  has_many :categories, dependent: :destroy

  enum salary: %i[
    under_twenty
    twenty_to_thirty_five
    thirty_five_to_fifty_five
    fifty_five_to_eighty
    eighty_to_hundred_and_ten
    over_hundred_and_ten
    non_paid
    not_say
  ]

  enum redundancy: %i[
    never
    voluntary
    once
    more_than_once
    r_not_say
  ]

  # Role categories (mostly) taken from https://en.wikipedia.org/wiki/International_Standard_Classification_of_Occupations
  enum role: %i[
    manager
    professional
    technician
    administrative
    service
    agriculture
    craft
    factory
    armed
    food
    other
  ]

  def percent
    score = 0
    categories.each do |category|
      score += category.percent_for_subtype
    end

    score / 4
  end

  def self.priority_countries
    %w[US GB]
  end
end
