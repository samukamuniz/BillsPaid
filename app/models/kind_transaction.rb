class KindTransaction < ActiveRecord::Base
	has_many :categories
	has_many :transactions
	validates_presence_of :description
	validates_uniqueness_of :description
end
