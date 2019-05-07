# frozen_string_literal: true

module API
  module V1
    class Base < Core
      helpers Pundit
      version 'v1', using: :path, vendor: 'moolah'
      formatter :json, Grape::Formatter::ActiveModelSerializers
      content_type :json, V1::Constants::CONTENT_TYPE

      mount Categories::Base
      mount Expenses::Base
      mount MonthlyIncomes::Base
      mount Users::Base
    end
  end
end
