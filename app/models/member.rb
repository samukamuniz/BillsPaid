class Member < ActiveRecord::Base
	has_many :accounts
	has_many :categories
	has_many :transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
