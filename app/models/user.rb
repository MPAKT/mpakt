# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  has_one :profile

  validates :short_name, presence: true
  accepts_nested_attributes_for :profile, reject_if: :all_blank, allow_destroy: true

  delegate :to_s, to: :short_name
  delegate :description, to: :profile
end
