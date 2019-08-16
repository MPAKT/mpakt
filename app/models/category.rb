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
    score = value_for_subtype
    score * 100 / 25
  end

  def value_for_subtype
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
    score -= 5 if c == 2 && score.positive?

    score
  end

  def ability_percent
    score = 0

    score += ability_weights[a]
    score += ability_weights[b]
    score += ability_weights[c]

    score += 7 if d == 2
    score += 5 if d == 1

    score
  end

  def caste_percent
    score = caste_calculations

    score += 1 if d.zero?
    score -= 1 if d == 2 && score.positive?

    score
  end

  def race_percent
    score = 0

    score += race_weights[a]
    score += race_weights[b]
    score += race_weights[c]

    score += 1 if d.zero?
    score -= 1 if d == 2 && score.positive?

    score
  end

  def ability_weights
    [6, 3, 0]
  end

  def caste_calculations
    caste_weights = [8, 5, 1, 0]
    score = 0

    [a, b, c].each do |param|
      param = 0 if param.blank?
      score += caste_weights[param]
    end

    score
  end

  def race_weights
    [5, 2, 1, 0, 1, 4]
  end
end
