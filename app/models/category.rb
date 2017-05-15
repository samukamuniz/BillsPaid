class Category < ActiveRecord::Base
  belongs_to :member
  has_many :transactions
  enum kind_transaction: [:expenses, :incomes]

  def kind_transaction_br
  	if self.kind_transaction == 'expenses'
  		'Despesasss'
  	else
  		'Receitasss'
  	end  	
  end
end
