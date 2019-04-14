# frozen_string_literal: true

module API
  module Helpers
    module JSONAPIParamsHelpers
      extend Grape::API::Helpers

      # Helper params for `:json_api_request` internal usage. Creates JSON API
      # structure for attributes. Required attributes will be required by Grape.
      params :attributes do |options|
        optional :attributes, type: Hash do
          options[:required]&.each do |param|
            requires param[:name], API::V1::Helpers::JSONAPIParamsHelpers.param_options(param)
          end
          options[:optional]&.each do |param|
            optional param[:name], API::V1::Helpers::JSONAPIParamsHelpers.param_options(param)
          end
        end
      end

      # Helper allowing to provide included resources in a string.
      # ```
      # params do
      #   use :json_api_include, resource: ExampleResource
      # end
      # ```
      params :json_api_include do |options|
        if options[:resource].present? && options[:resource].associations.any?
          associations = options[:resource]._relationships.keys.map(&:to_s)
          optional :include,
                    type: String,
                    desc: 'Include associations (delimited with comma). '\
                          "Available associations: #{associations.join(', ')}"
        end
      end

      # Helper allowing to provide optional param which change in what language
      # resource will be returned
      # ```
      # params do
      #   use :locale
      # end
      params :locale do |_options|
        optional :locale,
                  desc: 'Locale that the resource should be displayed for',
                  values: I18nData.languages.keys.map(&:downcase)
      end

      # Helper params used to structure POST and PATCH params according to
      # JSON API convention. Example usage in Grape controller:
      # ```
      # params do
      #   use :json_api_request,
      #       id?: true,
      #       type: %w(reviews),
      #       optional: [
      #         { name: :title, type: String },
      #       ],
      #       relationships: [
      #         { name: :business, required?: false, desc: "Related business ID" },
      #       ]
      # end
      # ```
      # Which creates required params structure:
      # ```
      # {
      #   "data": {
      #     "type": "reviews",
      #     "attributes": {
      #       "title": "Stunning.",
      #     },
      #     "relationships": {
      #       "business": {
      #         "data": {
      #           "type": "business",
      #           "id": "9"
      #         }
      #       }
      #     }
      #   }
      # }
      # ```
      params :json_api_request do |options|
        requires :data, type: Hash do
          requires :id, type: String if options[:id?]
          requires :type, type: String, values: options[:type]
          use :attributes, required: options[:required], optional: options[:optional]
          options[:relationships]&.each do |relation|
            if options[:validation]&.include?(relation[:name])
              use :validated_optional_relationships,
                  { validation: options[:validation] }.merge!(relation)
            elsif relation[:required?]
              use :required_relationships, relation
            else
              use :optional_relationships, relation
            end
          end
        end
      end

      # Helper params for `:json_api_request` internal usage. It allows to set optional
      # JSON API relationships params. Relationships params should be optional in PATCH requests.
      params :optional_relationships do |relation|
        optional :relationships, type: Hash do
          use :single_optional_relation, relation
        end
      end

      # Helper params for `:json_api_request` internal usage. It allows to set required
      # JSON API relationships params. Relationships params should be required in POST
      # requests to resources which should not be created without relationship.
      params :required_relationships do |relation|
        requires :relationships, type: Hash do
          requires relation[:name], type: Hash do
            requires :data, type: Hash do
              requires :type, type: String, values: [relation[:name].to_s]
              requires :id, type: String, desc: relation[:desc]
            end
          end
        end
      end

      # Helper params for `:optional_relationships` and `:validated_optional_relationships`
      # internal usage. It exports optional params to make methods more DRY.
      params :single_optional_relation do |relation|
        optional relation[:name], type: Hash do
          optional :data, type: Hash do
            optional :type, type: String, values: [relation[:name].to_s]
            optional :id, type: String, desc: relation[:desc]
          end
        end
      end

      # Helper params for `:json_api_request` internal usage. It allows to use `grape` params
      # validators: `mutually_exclusive`, `exactly_one_of`, `at_least_one_of`, `all_or_none_of`.
      # In this case hash argument `relationships` must be required.
      # Example of usage in grape controller `json_api_request`:
      # ```
      # relationships: [
      #   { name: :business, required?: false, desc: "Related business ID" },
      #   { name: :user, required?: false, desc: "Related user ID" },
      # ],
      # validation: [:exactly_one_of, :business, :user]
      # ```
      params :validated_optional_relationships do |relation|
        validator = relation[:validation].first
        params = relation[:validation][1..-1]
        if %i[all_or_none_of mutually_exclusive].include?(validator)
          optional :relationships, type: Hash do
            use :single_optional_relation, relation
            public_send(validator, *params)
          end
        else
          requires :relationships, type: Hash do
            use :single_optional_relation, relation
            public_send(validator, *params)
          end
        end
      end

      # Helper method for `:attributes` internal usage. It allows to set normal Grape
      # options for params, like `type`, `desc` etc.
      def self.param_options(param)
        options = {
          values: param[:values],
          desc: param[:desc]
        }
        param[:default] ? options[:default] = param[:default] : options
        param[:types] ? options.merge!(types: param[:types]) : options.merge!(type: param[:type])
      end
    end
  end
end
