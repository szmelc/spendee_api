# frozen_string_literal: true

module API
  module V1
    module Categories
      class Index < Base
        desc 'Get a list of all categories'
        get do
          authenticate!
          authorize Category, :index?

          categories = Category.all
          render categories
        end
      end
    end
  end
end
