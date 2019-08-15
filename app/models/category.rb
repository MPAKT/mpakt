# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :privilege

  enum subtype: %i[
    ability
    caste
    race
    gender
  ]

  def percent_for_subtype
    case subtype
    when "gender"
      gender_percent
    end
  end

  def gender_percent
    score = 0
    score += 15 if a.positive?
    score += 5 if b.positive?
    score += 5 if c.zero?
    score -= 5 if c == 2 && score > 0

    puts "========"
    puts score
    puts score / 25
    puts "========"

    score * 100 / 25
  end
end
