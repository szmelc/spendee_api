# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    association :user
    name { 'Groceries' }
    description { 'Christmas grocery shopping' }
    amount { 12.22 }
    currency { 'PLN' }
  end
end
