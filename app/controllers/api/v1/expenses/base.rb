# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Base < Base
        mount API::V1::Auth
        resource :expenses do
          mount Expenses::Create
          mount Expenses::Index
          route_param :year, type: Integer do
            mount Expenses::Sum
          end
        end
      end
    end
  end
end
