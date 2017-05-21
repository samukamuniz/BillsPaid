class Site::IncomesController < Site::TransactionsController
  before_action :set_transaction, only: [:edit, :update, :destroy]
  
  def index
    @transactions = Transaction.where(kind_transaction: 2, member_id: current_member).order('date DESC')
    @transaction_type = 2
  end

  def new
    @transaction = Transaction.new
		@anddress = site_incomes_path
  end

  def edit
		@anddress = site_income_path
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.member = current_member
    @transaction.kind_transaction = 2

    if @transaction.paid == true
      credit
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to site_incomes_path, notice: "A Transação (#{@transaction.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
      
    def credit #Adciona valor recebido para a conta informada
      @account_actual = Account.find(@transaction.account_id) 
      @account_actual.update(amount: @account_actual.amount + @transaction.amount)
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:member_id, :kind_transaction, :description, :amount, :date, :category_id, :account_id, :paid)
    end
end
