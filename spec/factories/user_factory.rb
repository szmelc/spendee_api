# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'test@test.com' }
    password { '123123' }
  end
end
