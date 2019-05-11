# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Destroy < Base
        desc 'Deletes an expense'
        route_param :id, type: Integer do
          delete do
            authenticate!
            authorize Expense, :destroy?
            data = declared(params)
            result = ExpenseServices::Destroy.call(current_user, data)
            render result.data
          end
        end
      end
    end
  end
end
