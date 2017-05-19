class Site::TransactionsController < SiteController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    category_opcoes_select
    account_opcoes_select
  end

  # GET /transactions/1/edit
  def edit
    category_opcoes_select
    account_opcoes_select
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.kind_transaction = 1
    @transaction.member_id = current_member
    
    if @transaction.kind_transaction == 1
      if @transaction.paid == true
        expense
      end
    else
      if @transaction.paid == true
        income
      end
    end
    
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to site_transactions_path, notice: "A Transação (#{@transaction.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update

    @check = Transaction.find(@transaction.id)

    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to site_transactions_path, notice: "A Transação (#{@transaction.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end

    if (@check.account_id) == (@transaction.account_id)
      #Atualiza o valor da conta que estava pendente 
      if (@check.paid == false) && (@transaction.paid == true)
        if @transaction.kind_transaction == 1
            expense
        else
            income
        end
      end

      #Atualiza o valor da conta que já estava paga
      if (@check.paid == true) && (@transaction.paid == true)
        update_expense_true
      end

      #Atualiza o valor da conta que foi desmarcada como paga
      if (@check.paid == true) && (@transaction.paid == false)
        update_expense_false
      end
    
    else
      returnsMoneyToInitialAccount
      migrateAmountToAccount
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
  	transacao = @transaction.description
    @check = Transaction.find(@transaction.id)

    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to site_transactions_path, notice: "A Transação (#{transacao}) foi deletada com sucesso!" }
      format.json { head :no_content }
    end

    if @transaction.kind_transaction == 1
      returnsMoneyToInitialAccount
    else
      migrateAmountToAccount
    end
  end

  private
    def category_opcoes_select
      @category_options_for_select = Category.where(kind_transaction: 1, member_id: current_member)
    end

    def account_opcoes_select
      @account_options_for_select = Account.where(member_id: current_member)
    end

    def returnsMoneyToInitialAccount
      aux = Account.find(@check.account_id)
      aux.amount += @check.amount 
      aux.save
    end

    def migrateAmountToAccount
      aux = Account.find(@transaction.account_id)
      aux.amount -= @transaction.amount 
      aux.save
    end

    def update_expense_true
      if @check.amount > @transaction.amount
        aux = Account.find(@transaction.account_id)
        aux.amount += (@check.amount - @transaction.amount)
        aux.save
      else
        aux = Account.find(@transaction.account_id)
        aux.amount -= (@transaction.amount - @check.amount)
        aux.save
      end
    end

    def update_expense_false
      aux = Account.find(@transaction.account_id)
      aux.amount += @transaction.amount
      aux.save
    end

    def expense
      aux = Account.find(@transaction.account_id)
      aux.amount = aux.amount - @transaction.amount
      aux.save
    end

    def income
      aux = Account.find(@transaction.account_id)
      aux.amount = aux.amount + @transaction.amount
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

