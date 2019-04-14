# frozen_string_literal: true

require 'grape-swagger'

module API
  class Core < Grape::API
    prefix :api
    format :json
    include Grape::Kaminari
    helpers API::Helpers::JSONAPIHelpers
    helpers API::Helpers::JSONAPIParamsHelpers
    helpers API::UserHelpers
    helpers API::ResponseHelpers
    rescue_from Pundit::NotAuthorizedError, with: :not_found

    helpers do
      def User.permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end

      def resources_with_pagination(resources, resources_name, serializer, scope, options = {})
        pagination = {
          total_pages: options.fetch(:total_pages) { resources.total_pages },
          number_of_records: options.fetch(:total_count) { resources.total_count },
        }
        if options.fetch(:root, nil).present?
          pagination = { options.fetch(:root) => pagination }
        end
        pagination.merge!(
          resources_name => ActiveModel::ArraySerializer.new(
            resources, each_serializer: serializer, scope: scope
          ),
        )
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
