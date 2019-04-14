# frozen_string_literal: true

module API
  module V1
    module Categories
      class Base < Base
        mount API::V1::Auth
        resource :categories do
          mount Categories::Index
        end
      end
    end
  end
end
