# frozen_string_literal: true

class ExpensePolicy < ApplicationPolicy
  def create?
    ensured_user_authenticated?
  end
end
