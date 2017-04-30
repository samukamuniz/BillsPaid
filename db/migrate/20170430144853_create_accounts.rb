class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :description
      t.decimal :amount, :decimal, precision: 5, scale: 2
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
