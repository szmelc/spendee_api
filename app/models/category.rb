# frozen_string_literal: true

class Category < ApplicationRecord
  NAMES = %w[TRANSPORT FOOD HEALTH LEISURE CLOTHING BILLS RENT ALCOHOL].freeze

  validates :name, presence: true, inclusion: { in: NAMES }
  validates :ordering, numericality: true

  has_many :expenses
end
