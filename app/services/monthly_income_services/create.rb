# frozen_string_literal: true

module MonthlyIncomeServices
  class Create < ApplicationService
    attr_private_initialize :user, :income, :params

    def call
      income = user.monthly_incomes.new(amount: params[:amount])
      income.save! ? success('Income created', income: income) : failure(income.errors)
    end
  end
end