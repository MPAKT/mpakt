# frozen_string_literal: true

class Privilege < ApplicationRecord
  has_many :categories, dependent: :nullify

  enum salary: %i[
    under_twenty
    twenty_to_thirty_five
    thirty_five_to_fifty_five
    fifty_five_to_eighty
    eighty_to_hundred_and_ten
    over_hundred_and_ten
    not_say
  ]
end
