# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :name, :color, :ordering, :total_amount

  def name
    object.name.capitalize
  end

  def total_amount
    object.try(:total)
  end
end