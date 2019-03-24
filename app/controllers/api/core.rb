# frozen_string_literal: true

require 'grape-swagger'

module API
  class Core < Grape::API
    prefix :api
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    helpers API::UserHelpers
    helpers API::ResponseHelpers
    rescue_from Pundit::NotAuthorizedError, with: :not_found

    helpers do
      def User.permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end

      def logger
        Rails.logger
      end

      def authenticate!
        unauthorized unless current_user
      end
    end

    mount API::V1::Base
    add_swagger_documentation \
      mount_path: '/docs',
      produces: 'application/vnd.api+json',
      info: {
        title: 'Spendee API.',
        contact_name: 'Łukasz Szmelc',
        contact_email: 'lukasz.szmelc@netguru.co'
      }
  end
end
