# frozen_string_literal: true

module Result
  class Failure < Base
    def success?
      false
    end

    def flash
      { alert: message }
    end

    def error_key
      return data[:error_key] if data.present? && data.key?(:error_key)

      message.parameterize.underscore
    end
  end
end
