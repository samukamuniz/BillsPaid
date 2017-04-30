class Category < ActiveRecord::Base
  belongs_to :kind_transaction
  has_many :transactions
end
