class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :kind_transaction
      t.references :member, index: true, foreign_key: true
      t.string :description
      
      t.timestamps null: false
    end
  end
end
