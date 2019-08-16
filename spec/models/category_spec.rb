# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category do
  describe "#ability_score=" do
    it "should calculate the score correctly" do
      category = Category.new(subtype: :ability, a: 2, b: 2, c: 2, d: 2)
      expect(category.ability_score).to be_zero

      category = Category.new(subtype: :ability, a: 1, b: 1, c: 1, d: 1)
      expect(category.ability_score).to eq 14

      category = Category.new(subtype: :ability, a: 0, b: 0, c: 0, d: 0)
      expect(category.ability_score).to eq 25

      category = Category.new(subtype: :ability)
      expect(category.ability_score).to eq 25
    end
  end

  describe "#caste_score=" do
    it "should calculate the score correctly" do
      category = Category.new(subtype: :caste, a: 3, b: 3, c: 3, d: 2)
      expect(category.caste_score).to be_zero

      category = Category.new(subtype: :caste, a: 2, b: 2, c: 2, d: 2)
      expect(category.caste_score).to eq 3

      category = Category.new(subtype: :caste, a: 1, b: 1, c: 1, d: 1)
      expect(category.caste_score).to eq 16

      category = Category.new(subtype: :caste, a: 0, b: 0, c: 0, d: 0)
      expect(category.caste_score).to eq 25

      category = Category.new(subtype: :caste)
      expect(category.caste_score).to eq 25
    end
  end

  describe "#race_score=" do
    it "should calculate the score correctly" do
      category = Category.new(subtype: :race, a: 5, b: 5, c: 5, d: 5, e: 2)
      expect(category.race_score).to eq 25

      category = Category.new(subtype: :race, a: 4, b: 4, c: 4, d: 4, e: 1)
      expect(category.race_score).to eq 4

      category = Category.new(subtype: :race, a: 3, b: 3, c: 3, d: 3, e: 1)
      expect(category.race_score).to be_zero

      category = Category.new(subtype: :race, a: 1, b: 1, c: 1, d: 1, e: 0)
      expect(category.race_score).to eq 8

      category = Category.new(subtype: :race, a: 0, b: 0, c: 0, d: 0, e: 0)
      expect(category.race_score).to eq 25

      category = Category.new(subtype: :race)
      expect(category.race_score).to eq 25
    end
  end

  describe "#gender_score=" do
    it "should calculate the score correctly" do
      category = Category.new(subtype: :gender, a: 3, b: 2, c: 1)
      expect(category.gender_score).to be_zero

      category = Category.new(subtype: :gender, a: 2, b: 2, c: 1)
      expect(category.gender_score).to eq 3

      category = Category.new(subtype: :gender, a: 1, b: 1, c: 2)
      expect(category.gender_score).to be_zero

      category = Category.new(subtype: :gender, a: 0, b: 0, c: 0)
      expect(category.gender_score).to eq 25

      category = Category.new(subtype: :gender)
      expect(category.gender_score).to eq 25
    end
  end
end

