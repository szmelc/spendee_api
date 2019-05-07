# frozen_string_literal: true

module API
  module V1
    module MonthlyIncomes
      class Update < Base
        desc "Update user's monthly income"
        params do
          optional :amount, type: BigDecimal, desc: "Updated monthly income amount"
        end
        route_param :month_id, type: Integer do
          post '/' do
            authenticate!
            authorize MonthlyIncome, :update?
            data = declared(params)
            date = Date.new(data[:year], data[:month_id])
            if income = current_user.monthly_incomes.where('created_at BETWEEN ? AND ?', date, date.end_of_month).first
              income.update(amount: data[:amount])
            else
              current_user.monthly_incomes.create(amount: data[:amount])
            end
          end
        end
      end
    end
  end
end
