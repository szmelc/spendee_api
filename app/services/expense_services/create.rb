# frozen_string_literal: true

module ExpenseServices
  class Create < ApplicationService
    attr_private_initialize :user, :params

    def call
      expense = user.expenses.new(params)
      expense.save! ? success('Expense created', expense: expense) : failure(expense.errors)
    end
  end
end