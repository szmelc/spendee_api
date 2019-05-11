# frozen_string_literal: true

module ExpenseServices
  class Destroy < ApplicationService
    attr_private_initialize :user, :params

    def call
      expense = Expense.find(params[:id])
      if expense.destroy! 
        update_user_savings(expense)
        success('Expense destroyed', expense: expense)
      else
        failure(expense.errors)
      end
    end

    private

    def update_user_savings(expense)
      updated_savings = user.total_savings + expense.amount
      UserServices::Update.call(user, { total_savings: updated_savings })
    end
  end
end