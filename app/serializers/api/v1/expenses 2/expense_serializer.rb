# frozen_string_literal: true

module API
  module V1
    module Expenses
      class ExpenseSerializer < ActiveModel::Serializer
        attributes :amount, :name, :id

        has_one :category
      end
    end
  end
end
