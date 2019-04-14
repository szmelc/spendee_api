# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'TRANSPORT' }
    ordering { 1 }
    color { '#000' }
  end
end
