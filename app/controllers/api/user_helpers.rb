
# frozen_string_literal: true

module API
  module UserHelpers
    extend Grape::API::Helpers
    def current_user
      @current_user = DecodeAuthenticationCommand.call(request.headers).result
    end
  end
end
