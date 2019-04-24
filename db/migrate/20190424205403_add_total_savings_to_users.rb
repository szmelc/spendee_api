class AddTotalSavingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_savings, :decimal, default: 0
  end
end
