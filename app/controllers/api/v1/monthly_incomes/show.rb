# frozen_string_literal: true

module API
  module V1
    module MonthlyIncomes
      class Show < Base
        desc "Return user's latest monthly income"
        params do
          requires :month_id, type: Integer, desc: "Month identification number"
        end
        route_param :month_id do
          get '/' do
            authenticate!
            authorize MonthlyIncome, :show?
            data = declared(params)
            date = Date.new(data[:year], data[:month_id])
            current_user.monthly_incomes.where('created_at BETWEEN ? AND ?', date, date.end_of_month).first
          end
        end
      end
    end
  end
end
