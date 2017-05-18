class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :description
      t.integer :amount_cents, default: 0 
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
