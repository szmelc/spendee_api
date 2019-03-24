# frozen_string_literal: true

module UserServices
  class Register < ApplicationService
    attr_initialize :params

    def self.call(params)
      user = User.new(params)
      user.save! ? success('User has been created', user) : failure
    end
  end
end
