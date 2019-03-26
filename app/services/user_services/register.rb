# frozen_string_literal: true

module UserServices
  class Register < ApplicationService
    attr_private_initialize :params

    def call
      user = User.new(params)
      user.save! ? success('User has been created', user: user) : failure
    end
  end
end
