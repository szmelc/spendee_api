# frozen_string_literal: true

module API
  module V1
    class Base < Core
      helpers Pundit
      version 'v1', using: :path, vendor: 'spendee'
      content_type :json, V1::Constants::CONTENT_TYPE

      mount Expenses::Base
      mount Users::Base
    end
  end
end
