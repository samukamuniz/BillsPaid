class Category < ActiveRecord::Base
  belongs_to :member
  has_many :transactions
  enum kind_transaction: [:bills, :invoices]

  def kind_transaction_br
  	if self.kind_transaction == 'bills'
  		'Despesasss'
  	else
  		'Receitasss'
  	end  	
  end
end
