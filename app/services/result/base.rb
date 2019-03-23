# frozen_string_literal: true

module Result
  # Result object returned by all services. It can be either {Result::Success} or {Result::Failure}
  #
  # It responds to {.success?} and {.failure?} methods which indicate if service call succeed.
  # It provides {.flash?} method for controllers.
  #
  # Example of usage:
  #
  # Inside `SampleServices::DoSomething#call`:
  #
  # ```
  # return Result::Success.new(data: { id: id }, message: "Did something")
  # # or
  # return Result::Failure.new(data: { error: e }, message: "Failed to do something")
  # ```
  #
  # Inside controller:
  # ```
  # result = SampleServices::DoSomething.call
  # if result.success?
  #   id = result.data[:id]
  #   redirect_to on_success_path(id: id), flash: result.flash # notice "Did something"
  # else
  #   rollbar.info(result.data[:error])
  #   redirect_to on_failure_path, flash: result.flash # alert "Failed to do something"
  # end
  # ```
  class Base < ApplicationService
    attr_reader_initialize(%i[data message])

    def success?
      raise NotImplementedError
    end

    def failure?
      !success?
    end

    # Creates flash hash that can be used in controller redirects.
    def flash
      raise NotImplementedError
    end
  end
end
