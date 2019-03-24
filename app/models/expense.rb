# frozen_string_literal: true

class Expense < ApplicationRecord
  validates :amount, :currency, :name, presence: true
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :user
  has_one :expense_category, dependent: :destroy
  has_many :categories, through: :expense_category
end
