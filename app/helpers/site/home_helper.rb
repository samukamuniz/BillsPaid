module Site::HomeHelper
  def sald_to_account
    @sald = Account.sum('amount_cents')
  end

  def total_incomes
    @sald = Transaction.where(member: current_member, kind_transaction: 2).sum("amount_cents")
  end

  def total_expenses
    @sald = Transaction.where(member: current_member, kind_transaction: 1).sum("amount_cents")
  end










  	#@contas = Account.where(member: current_member).sum("amount_cents")
  	#@receitas = Transaction.where(member: current_member, kind_transaction: 2)
  	#@despesas = Transaction.where(member: current_member, kind_transaction: 1).sum("amount_cents")
end
