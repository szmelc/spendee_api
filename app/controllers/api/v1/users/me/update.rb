# frozen_string_literal: true

module API
  module V1
    module Users
      module Me
        class Update < Base
          desc 'Update current user'
          params do
            optional :email, type: String, desc: "User's email"
            optional :first_name, type: String, desc: "User's first name"
            optional :last_name, type: String, desc: "User's last name"
            optional :predicted_monthly_income, type: BigDecimal, desc: "User's predicted monthly income"
            optional :total_savings, type: BigDecimal, desc: "User's total savings"
          end
          post do
            authenticate!
            authorize current_user, :me?
            data = declared(params)
            result = UserServices::Update.call(current_user, data)
            render result.data
          end
        end
      end
    end
  end
end
