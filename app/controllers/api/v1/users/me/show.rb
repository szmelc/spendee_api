# frozen_string_literal: true

module API
  module V1
    module Users
      module Me
        class Show < Base
          desc 'Return current user'
          get '/', serializer: API::V1::Users::Me::UserSerializer do
            authenticate!
            authorize current_user, :me?
            render current_user
          end
        end
      end
    end
  end
end
