module Site::ExpensesHelper

  def category_options
    @category_expenses = Category.where(kind_transaction: 1, member_id: current_member)
  end

  def account_options
    @accountUser = Account.where(member_id: current_member)
  end
  
end
