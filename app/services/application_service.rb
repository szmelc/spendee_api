# frozen_string_literal: true

class ApplicationService
  def self.success(message = nil, data = nil)
    Result::Success.new(message: message, data: data)
  end

  def self.failure(message: nil, data: nil)
    Result::Failure.new(message: message, data: data)
  end
end
