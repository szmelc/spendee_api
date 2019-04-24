# frozen_string_literal: true

class CategoryExpensesSerializer < ActiveModel::Serializer
  attributes :id, :dupa

  def dupa
    binding.pry
  end
end