# frozen_string_literal: true

class ExpenseSerializer < ActiveModel::Serializer
  attributes :amount, :created_at, :currency, :id, :name

  has_one :category, serializer: CategorySerializer
end