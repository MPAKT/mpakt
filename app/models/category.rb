# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :privilege

  enum subtype: %i[
    ability
    caste
    ethnicity
    gender
  ]

  def percent_for_subtype
    score = value_for_subtype
    score * 100 / 25
  end

  def value_for_subtype
    case subtype
    when "gender"
      gender_score
    when "ability"
      ability_score
    when "caste"
      caste_score
    when "ethnicity"
      ethnicity_score
    end
  end

  def gender_score
    score = gender_calculations

    return score + 5 if c.blank? || c.zero?
    score -= 3 if c == 2 && score.positive?

    # Category d is saved in the database, but currently not scored. If we get analysis that show it has an
    # impact on salaries, we should add it here.
    score
  end

  def gender_calculations
    score = calculations(gender_weights_a, [a])
    score + calculations(gender_weights_b, [b])
  end

  def ability_score
    score = calculations(ability_weights)

    return score + 7 if d.blank? || d.zero?
    score += 2 if d == 1

    score
  end

  def caste_score
    score = calculations(caste_weights)

    return score + 1 if d.blank? || d.zero?
    score -= 1 if d == 2 && score.positive?

    score
  end

  def ethnicity_score
    score = calculations(ethnicity_weights, [a,b,c,d])

    return score + 1 if e.blank? || e.zero?
    score -= 1 if e == 2 && score.positive?

    score
  end

  def gender_weights_a
    [15, 0, 0, 12]
  end

  def gender_weights_b
    [5, 0, 3]
  end

  def ability_weights
    [6, 2, 0]
  end

  def caste_weights
    [8, 5, 1, 0]
  end

  def ethnicity_weights
    [6, 2, 1, 0, 1, 4]
  end

  def calculations(weights, keys = [a, b, c])
    score = 0

    keys.each do |param|
      score_to_add = param.blank? ? weights[0] : weights[param]
      score += score_to_add
    end

    score
  end
end
