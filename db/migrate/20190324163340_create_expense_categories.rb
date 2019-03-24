class CreateExpenseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_categories do |t|
      t.references :expense, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
