class CreateKindTransactions < ActiveRecord::Migration
  def change
    create_table :kind_transactions do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
