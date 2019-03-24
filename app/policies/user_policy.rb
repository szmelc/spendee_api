# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def me?
    ensured_current_user?
  end
end
