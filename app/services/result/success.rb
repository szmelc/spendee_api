
# frozen_string_literal: true

module Result
  class Success < Base
    def success?
      true
    end

    def flash
      { notice: message }
    end
  end
end
