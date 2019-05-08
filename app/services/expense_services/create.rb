# frozen_string_literal: true

module ExpenseServices
  class Create < ApplicationService
    attr_private_initialize :user, :params

    def call
      expense = user.expenses.new(params)
      update_user_savings(expense)
      expense.save! ? success('Expense created', expense: expense) : failure(expense.errors)
    end

    private

    def update_user_savings(expense)
      updated_savings = user.total_savings - expense.amount
      UserServices::Update.call(user, { total_savings: updated_savings })
    end
  end
end