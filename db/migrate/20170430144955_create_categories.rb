class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :description
      t.references :kind_transaction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
