# frozen_string_literal: true
# TODO: Add spcc

class ExpensePolicy < ApplicationPolicy
  def index?
    ensured_user_authenticated?
  end

  def create?
    ensured_user_authenticated?
  end

  def destroy?
    ensured_user_authenticated?
  end  

  def sum?
    ensured_user_authenticated?
  end  
end
