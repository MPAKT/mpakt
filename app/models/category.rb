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
    when "ability"
      ability_percent
    when "caste"
      caste_percent
    when "race"
      race_percent
    end
  end

  def gender_percent
    score = 0
    score += 15 if a.positive?
    score += 5 if b.positive?
    score += 5 if c.zero?
    score -= 5 if c == 2 && score > 0

    score * 100 / 25
  end

  def ability_percent
    score = 0
    ability_weights = [6, 3, 0]

    score += ability_weights[a]
    score += ability_weights[b]
    score += ability_weights[c]

    score += 7 if d == 2
    score +=5 if d == 1

    score * 100 / 25
  end

  def caste_percent
    score = 0
    caste_weights = [8, 5, 1, 0]

    score += caste_weights[a]
    score += caste_weights[b]
    score += caste_weights[c]

    score += 1 if d.zero?
    score -= 1 if d == 2 && score > 0

    score * 100 / 25
  end

  def race_percent
    score = 0
    race_weights = [5, 2, 1, 0, 1, 4]

    score += race_weights[a]
    score += race_weights[b]
    score += race_weights[c]

    score += 1 if d.zero?
    score -= 1 if d == 2 && score > 0

    score * 100 / 25
  end
end
