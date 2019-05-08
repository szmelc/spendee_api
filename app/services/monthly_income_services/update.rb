# frozen_string_literal: true

module MonthlyIncomeServices
  class Update < ApplicationService
    attr_private_initialize :user, :income, :params

    def call
      update_total_savings(income, params[:amount])
      income.assign_attributes(amount: params[:amount])
      income.save! ? success('Income updated', income: income) : failure(income.errors)
    end

    private

    def update_total_savings(old_income, updated_income)
      calculate_income_difference(old_income, updated_income)
    end

    def calculate_income_difference(old_income, updated_income)
      income_difference = updated_income - old_income.amount 
      updated_savings = user.total_savings + income_difference
      UserServices::Update.call(user, { total_savings: updated_savings })
    end
  end
end