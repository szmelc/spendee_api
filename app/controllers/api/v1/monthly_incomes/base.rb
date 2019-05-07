# frozen_string_literal: true

module API
  module V1
    module MonthlyIncomes
      class Base < Base
        mount API::V1::Auth
        resource :monthly_incomes do
          route_param :year, type: Integer do
            mount MonthlyIncomes::Show
            mount MonthlyIncomes::Update
          end
        end
      end
    end
  end
end
