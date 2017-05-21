module Site::IncomesHelper

  def category_options
    @kind = @transaction_type
    @Kind_category = Category.where(kind_transaction: @kind, member_id: current_member)
  end

	def account_options
    @accountUser = Account.where(member_id: current_member)
  end
end