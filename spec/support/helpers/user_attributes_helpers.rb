# frozen_string_literal: true

module Helpers
  module UserAttributesHelpers
    def current_user_attributes(user, serializer)
      serializer.new(user).attributes
    end
  end
end
