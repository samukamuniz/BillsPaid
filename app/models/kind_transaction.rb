	class KindTransaction < ActiveRecord::Base
		has_many :categories
		has_many :transactions
end
