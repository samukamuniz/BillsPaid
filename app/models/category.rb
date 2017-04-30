class Category < ActiveRecord::Base
  belongs_to :kind_transaction
  has_many :transactions

  accepts_nested_attributes_for :transactions
end
