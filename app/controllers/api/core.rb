# frozen_string_literal: true

require 'grape-swagger'

module API
  class Core < Grape::API
    prefix :api
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    error_formatter :json, Grape::Formatter::ActiveModelSerializers

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
