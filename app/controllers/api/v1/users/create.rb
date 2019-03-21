# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Base
        desc 'Create a user'
        params do
          optional :email, type: String
        end
        post do
          binding.pry
          data = declared(params)
          render data
        end
      end
    end
  end
end
