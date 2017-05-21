class Site::ExpensesController < Site::TransactionsController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.where(kind_transaction: 1, member: current_member)
  end

  def new
    @transaction = Transaction.new
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.member = current_member
    @transaction.kind_transaction = 1

    if @transaction.paid == true
      debit
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to site_expenses_path, notice: "A Transação (#{@transaction.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    

  end

  private

    def debit
      aux = Account.find(@transaction.account_id)
      aux.amount += - @transaction.amount
      aux.save
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:member_id, :kind_transaction, :description, :amount, :date, :category_id, :account_id, :paid)
    end
end