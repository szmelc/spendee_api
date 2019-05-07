# frozen_string_literal: true

module UserServices
  class Update < ApplicationService
    attr_private_initialize :user, :data

    def call
      user.assign_attributes(data)
      user.save! ? success('User has been updated', user: user) : failure
    end
  end
end
