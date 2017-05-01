class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :kind_transaction, index: true, foreign_key: true
      t.string :description
      t.decimal :amount, :decimal, precision: 5, scale: 2
      t.date :date
      t.references :category, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
