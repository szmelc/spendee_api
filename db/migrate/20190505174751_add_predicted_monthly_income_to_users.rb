class AddPredictedMonthlyIncomeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :predicted_monthly_income, :decimal, default: 0
  end
end
