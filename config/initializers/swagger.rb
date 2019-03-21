# frozen_string_literal: true

GrapeSwaggerRails.options.app_name = 'Spendee API documentation'
GrapeSwaggerRails.options.url = '/api/docs'

GrapeSwaggerRails.options.before_action_proc = proc {
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  (current_user&.admin?) || redirect_to('/admin/login') unless Rails.env.development?
}

GrapeSwaggerRails.options.hide_url_input = true
GrapeSwaggerRails.options.hide_api_key_input = false

# GrapeSwaggerRails.options.api_auth = 'bearer'
# GrapeSwaggerRails.options.api_key_name = 'Authorization'
# GrapeSwaggerRails.options.api_key_type = 'header'
