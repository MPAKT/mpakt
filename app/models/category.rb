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
    score = calculations(gender_weights_a)
    score += calculations(gender_weights_b)

    score -= 5 if c == 2 && score.positive?

    score
  end

  def ability_percent
    score = calculations(ability_weights)

    score += 7 if d == 2
    score += 5 if d == 1

    score
  end

  def caste_percent
    score = calculations(caste_weights)

    score += 1 if d.blank? || d.zero?
    score -= 1 if d == 2 && score.positive?

    score
  end

  def race_percent
    score = calculations(race_weights)

    score += 1 if d.blank? || d.zero?
    score -= 1 if d == 2 && score.positive?

    score
  end

  def gender_weights_a
    [15, 0]
  end

  def gender_weights_b
    [5, 0]
  end

  def ability_weights
    [6, 3, 0]
  end

  def caste_weights
    [8, 5, 1, 0]
  end

  def race_weights
    [5, 2, 1, 0, 1, 4]
  end

  def calculations(weights)
    score = 0

    [a, b, c].each do |param|
      param = 0 if param.blank?
      score += weights[param]
    end

    score
  end
end
