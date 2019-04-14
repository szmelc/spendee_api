# frozen_string_literal: true
# TODO: Add spcc

class CategoryPolicy < ApplicationPolicy
  def index?
    ensured_user_authenticated?
  end
end
