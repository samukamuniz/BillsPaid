class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  belongs_to :member
  monetize :amount_cents
  enum kind_transaction: {:expenses => 1, :incomes => 2}

  validates :kind_transaction, :category_id, :account_id, :description, :amount, :date, presence: true
  validates :amount, numericality: {greater_than: 0}

  def kind_transaction_br
  	if self.kind_transaction == 'expenses'
  		'Despesas'
  	else
  		'Receitas'
  	end  	
  end
end
