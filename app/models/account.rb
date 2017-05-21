class Account < ActiveRecord::Base
  belongs_to :member
  has_many :transactions

  validates :member, :description, presence: true
  validates :amount, numericality: {greater_than: 0}
  monetize :amount_cents
end
