# frozen_string_literal: true

module API
  module V1
    module Categories
      class Expenses < Base
        desc 'Get a list of expenses for each category'
        params do
          requires :month, type: Integer, desc: "Month for which expenses are to be listed"
          requires :year, type: Integer, desc: "Year for which expenses are to be listed"
        end

        get do
          authenticate!
          authorize Category, :index?

          data = declared(params)
          month, year = data[:month], data[:year]
          date = Date.new(year, month)

          categories = Category
                        .joins(:expenses)
                        .all
                        .where('expenses.created_at BETWEEN ? AND ?', date, date.end_of_month)
                        .select('categories.name, ordering, color, SUM(expenses.amount) AS total')
                        .group('categories.id')
          render categories, serializer: CategoryExpensesSerializer
        end
      end
    end
  end
end
