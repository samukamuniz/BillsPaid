class Account < ActiveRecord::Base
  belongs_to :member
  has_many :transactions

  monetize :amount_cents
end
