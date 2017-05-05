class Account < ActiveRecord::Base
  belongs_to :member
  has_many :transactions
  validates_presence_of :description, :member_id, :amount
  validates_associated :member
end
