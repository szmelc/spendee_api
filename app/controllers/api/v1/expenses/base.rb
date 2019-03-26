# frozen_string_literal: true

module API
  module V1
    module Expenses
      class Base < Base
        mount API::V1::Auth
        resource :expenses do
          mount Expenses::Create
        end
      end
    end
  end
end
