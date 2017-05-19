class Site::HomeController < SiteController 
  def index
  	#@receitas = Account.sum("amount_cents", member: current_member)
  	#@contas = Account.where(member: current_member).sum("amount_cents")
  	#@receitas = Transaction.where(member: current_member, kind_transaction: 2)
  	#@despesas = Transaction.where(member: current_member, kind_transaction: 1).sum("amount_cents")
 
  end
end
