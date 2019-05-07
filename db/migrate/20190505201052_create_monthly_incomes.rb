class CreateMonthlyIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_incomes do |t|
      t.references :user, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
