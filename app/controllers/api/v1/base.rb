module API
  module V1
    class Base < Core
      version 'v1', using: :path, vendor: 'spendee'
      content_type :json, V1::Constants::CONTENT_TYPE

      mount Users::Base
    end
  end
end
