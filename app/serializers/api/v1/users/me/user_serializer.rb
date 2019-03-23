module API
  module V1
    module Users
      module Me
        class UserSerializer < ActiveModel::Serializer
          attributes :email, :id
        end
      end
    end
  end
end
