class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.string :currency
      t.decimal :amount
      t.references :user, foreign_key: true
    end
  end
end
