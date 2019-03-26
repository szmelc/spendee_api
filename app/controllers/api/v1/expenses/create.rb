# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Create < Base
        desc 'Creates an expense'
        params do
          requires :amount, type: BigDecimal, desc: "Expense's amount"
          requires :currency, type: String, desc: "Expense's currency"
          requires :category_id, type: Integer, desc: "Expense's category id"
          optional :description, type: String, desc: "Expense's description"
          requires :name, type: String, desc: "Expense's name"
        end
        post do
          authenticate!
          authorize Expense, :create?
          data = declared(params).symbolize_keys
          result = ExpenseServices::Create.call(current_user, data)
          render result.data
        end
      end
    end
  end
end
