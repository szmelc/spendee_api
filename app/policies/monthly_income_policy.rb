# frozen_string_literal: true

class MonthlyIncomePolicy < ApplicationPolicy
  def show?
    ensured_user_authenticated?
  end

  def update?
    ensured_user_authenticated?
  end  
end
