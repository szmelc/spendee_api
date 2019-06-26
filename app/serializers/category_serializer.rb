# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :name, :color, :ordering
end