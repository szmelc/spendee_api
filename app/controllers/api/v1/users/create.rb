# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Base
        desc 'Create a user'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post do
          data = declared(params)
          result = UserServices::Register.call(data.symbolize_keys)
          render result.data
        end
      end
    end
  end
end
