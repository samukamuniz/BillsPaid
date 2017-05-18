class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :member, index: true, foreign_key: true
      t.integer :kind_transaction
      t.string :description
      t.integer :amount_cents, default: 0
      t.date :date
      t.references :category, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
