# frozen_string_literal: true
require 'attr_extras/explicit'

class ApplicationService
  extend AttrExtras::Mixin
  extend StaticFacade

  def success(message = nil, data = nil)
    Result::Success.new(message: message, data: data)
  end

  def failure(message: nil, data: nil)
    Result::Failure.new(message: message, data: data)
  end
end
