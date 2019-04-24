# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Index < Base
        desc 'Get a list of all expenses for given period'
        params do
          requires :month, type: Integer, desc: "Month for which expenses are to be listed"
          requires :year, type: Integer, desc: "Year for which expenses are to be listed"
        end

        get do
          authenticate!
          authorize Expense, :index?
          
          data = declared(params)
          month, year = data[:month], data[:year]
          date = Date.new(year, month)

          expenses = current_user.expenses.all.includes(:category).where('created_at BETWEEN ? AND ?', date, date.end_of_month).order('created_at desc')
          collection = paginate(expenses)
          render collection, render_options(meta_pagination(collection))
        end
      end
    end
  end
end
