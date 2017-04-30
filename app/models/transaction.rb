class Transaction < ActiveRecord::Base
  belongs_to :kind_transaction
  belongs_to :category
  belongs_to :account
end
