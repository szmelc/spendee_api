# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true

  has_many :expenses, dependent: :destroy
  has_many :monthly_incomes, dependent: :destroy
end
