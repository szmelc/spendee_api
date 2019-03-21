# frozen_string_literal: true

require 'grape-swagger'

module API
  class Core < Grape::API
    prefix :api
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    error_formatter :json, Grape::Formatter::ActiveModelSerializers
    helpers API::UserHelpers
    helpers API::ResponseHelpers

    helpers do
      def permitted_params
        @permitted_params ||= declared(params,
                                       include_missing: false)
      end

      def logger
        Rails.logger
      end

      def authorize!
        unauthorized if !current_user && !current_user.admin?
        true
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
