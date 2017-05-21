class Site::IncomesController < Site::TransactionsController
  before_action :set_transaction, only: [:edit, :update, :destroy]
  
  def index
    @transactions = Transaction.where(kind_transaction: 2, member_id: current_member).order('date DESC')
    @transaction_type = 2
  end
end
