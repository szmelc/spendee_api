# frozen_string_literal: true

module API
  module ResponseHelpers
    extend Grape::API::Helpers
    def errors(errors)
      { errors: errors }
    end

    def unauthorized(message="Unauthorized")
      error!({ errors: message }, 401)
    end

    def bad_request(message="Bad Request")
      error!({ errors: message }, 400)
    end

    def not_found(message="Record not found")
      error!({ errors: message }, 404)
    end

    def unprocessable_entity(message="Unprocessable entity")
      error!({ errors: message }, 422)
    end
  end
end
