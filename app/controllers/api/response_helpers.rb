# frozen_string_literal: true

module API
  module ResponseHelpers
    extend Grape::API::Helpers
    def errors(errors)
      { errors: errors }
    end

    def unauthorized(message = 'Unauthorized')
      error!({ error: message }, 401)
    end

    def bad_request(message = 'Bad Request')
      error!({ error: message }, 400)
    end

    def not_found(message = 'Record not found')
      error!({ error: message }, 404)
    end

    def unprocessable_entity(message = 'Unprocessable entity')
      error!({ error: message }, 422)
    end
  end
end
