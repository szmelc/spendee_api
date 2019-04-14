# frozen_string_literal: true

module API
  module Helpers
    module JSONAPIHelpers
      extend Grape::API::Helpers

      def check_accept_header!
        return unless request.headers['Accept'] != V1::Constants::CONTENT_TYPE

        return_error!(
          415,
          message: 'Unsupported Media Type',
          code: 'unsupported_media_type',
          detail: 'Accept HTTP header should be application/vnd.api+json'
        )
      end

      def change_locale(params)
        I18n.locale = params[:locale].to_sym if params[:locale].present?
      end

      def check_id_uniformity(params)
        return if params[:data][:id] == params[:id]

        return_error!(
          409,
          message: 'URL/params ID conflict',
          detail: 'ID in URL is different from ID in params',
          code: 'url_params_id_conflict'
        )
      end

      def json_api_attributes(params, any = true)
        attributes = params[:data][:attributes]
        return_error!(400, message: 'Missing attributes', code: 'missing_attributes') if attributes.blank? && any
        filter_id(attributes)
        attributes&.deep_symbolize_keys
      end

      def return_error!(status, message_hash, exception = nil)
        error = build_error_hash(message_hash, status)
        if Rails.env.development? && exception.present?
          error[:description] = exception.message
          error[:backtrace] = exception.backtrace
        end
        error!({ errors: [error] }, status)
      end

      def render_exception(status, exception)
        error = build_error_hash({ message: exception.message }, status)
        error[:backtrace] = exception.backtrace if Rails.env.development?
        error!({ errors: [error] }, status)
      end

      # Helper for returning response with many errors.
      # It requires errors messages and details formatted in ActiveRecord way
      # as `ActiveModel::Errors`.
      # All errors objects have the same http status.
      # More information in {RequestServices::SerializeErrors} documentation.
      def return_errors_array!(status, messages, details)
        result = RequestServices::SerializeErrors.call(
          messages: messages, details: details, status: status
        )
        error!(result.data, status)
      end

      def relation_id(params, relation)
        relationships(params)&.dig(relation, :data, :id)
      end

      def relationships(params)
        params[:data][:relationships]
      end

      # Helper to determine an instance of the model to which an object is related to
      # in case there is a polymorphic relation.
      # e.g. if new picture is related to Business and Review but a picture
      # related to an instance of Business model is created, #associated_record
      # returns the instance of Business model the picture is related to.
      def associated_record(params)
        relationship = relationships(params).keys[0]
        relationship.camelize.constantize.friendly_uuid_find!(relation_id(params, relationship.to_sym))
      end

      def render_options(context: {}, meta: {})
        options[:include] = params[:include].to_s.split(',').reject { |relation| relation.include?('.') }
        options[:meta] = meta if meta.present?
        options[:context] = context
        options
      end

      # Helper for returning associated records of resource.
      # Firstly it finds a resource (using either slug if supported or plain id),
      # then checks if it should return the records.
      def authorized_resource_with_includes_find(resource_class, association)
        resource = get_current_user_with_includes(association) if resource_class == User && params[:id].nil?
        resource ||= get_resource(resource_class.includes(association))

        resource.tap do |res|
          authorize res, "show_#{association}?".to_sym
        end
      end

      def get_resource(resource)
        resource.friendly_uuid_find!(params[:id])
      end

      def get_current_user_with_includes(association)
        User.includes(association).find(current_user.id)
      end

      def meta_pagination(paginated_collection)
        {
          meta: {
            'total-count' => paginated_collection.total_count,
            'total-pages' => paginated_collection.total_pages
          }
        }
      end

      # Helper for standard resource update. Firstly it checks if provided ids differ,
      # then authorize action, updates resource and finaly ruturns 204 no body status.
      def update_resource(resource, params)
        check_id_uniformity(params)
        resource.assign_attributes(json_api_attributes(params))
        authorize resource, :update?
        resource.save!
        resource
      end

      private

      def build_error_hash(error_hash, status)
        {
          title: error_hash[:message],
          detail: error_hash[:detail],
          code: error_hash[:code].presence,
          status: status
        }
      end

      def filter_id(attributes)
        attributes&.delete('id')
      end
    end
  end
end
