# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Sum < Base
        desc 'Get a sum of all expenses in a given month'
        route_param :month_id, type: Integer do
          namespace :sum do
            get do
              authenticate!
              authorize Expense, :sum?
              data = declared(params)
              month, year = data[:month_id], data[:year]
              date = Date.new(year, month)
    
              expenses = current_user.expenses.all.includes(:category).where('created_at BETWEEN ? AND ?', date, date.end_of_month).order('created_at desc')
              expenses.sum(:amount)
            end
          end
        end
      end
    end
  end
end
