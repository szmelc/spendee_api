# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Base < Base
        mount API::V1::Auth
        resource :expenses do
          mount Expenses::Create
          mount Expenses::Index
        end
      end
    end
  end
end
