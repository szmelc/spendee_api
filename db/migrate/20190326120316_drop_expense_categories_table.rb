class DropExpenseCategoriesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :expense_categories
  end
end
