# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :expense_categories
  has_many :expenses, through: :expense_categories
end
