# frozen_string_literal: true

module API
  module V1
    module Users
      class Base < Base
        resource :users do
          mount Users::Create
        end
      end
    end
  end
end
