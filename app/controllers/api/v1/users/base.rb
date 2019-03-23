# frozen_string_literal: true

module API
  module V1
    module Users
      class Base < Base
        mount API::V1::Auth
        resource :users do
          mount Users::Create

          namespace :me do
            mount Users::Me::Show
          end
        end
      end
    end
  end
end
