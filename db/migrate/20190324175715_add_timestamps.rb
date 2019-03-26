class AddTimestamps < ActiveRecord::Migration[5.2]
  def change
    change_table(:expenses) { |t| t.timestamps }
    change_table(:expense_categories) { |t| t.timestamps }
  end
end
