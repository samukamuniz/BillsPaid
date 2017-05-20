class Category < ActiveRecord::Base
  belongs_to :member
  has_many :transactions
  enum kind_transaction: {:expenses => 1, :incomes => 2}  

  def kind_transaction_br
  	if self.kind_transaction == 'expenses'
  		'Despesas'
  	elsif self.kind_transaction == 'incomes'
  		'Receitas'
    else
      'Sou nulo'
  	end  	
  end
end