# frozen_string_literal: true

class Expense < ApplicationRecord
  validates :amount, :category, :currency, :name, presence: true
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :category
end
