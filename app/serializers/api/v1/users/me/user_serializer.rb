# frozen_string_literal: true

module API
  module V1
    module Users
      module Me
        class UserSerializer < ActiveModel::Serializer
          attributes :email, :first_name, :last_name, :id, :predicted_monthly_income, :total_savings
        end
      end
    end
  end
end
