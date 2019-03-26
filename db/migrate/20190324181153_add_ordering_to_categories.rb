class AddOrderingToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :ordering, :integer
  end
end
