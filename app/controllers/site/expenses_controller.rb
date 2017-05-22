class Site::ExpensesController < SiteController#Site::TransactionsController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.where(kind_transaction: 1, member_id: current_member).order('date DESC')
    @transaction_type = 1
  end

  def new
    @transaction = Transaction.new
    @anddress = site_expenses_path
    @transaction_type = 1
  end

  def edit
    @anddress = site_expense_path
    @transaction_type = 1
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

  def update
    @transaction_save = Transaction.find(@transaction.id) #Busca no BD a Transação Existente e guarda os valores
    @account_save = Account.find(@transaction_save.account_id) #Busca a conta inicial da transação existente

    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to site_expenses_path, notice: "A Transação (#{@transaction.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    
    if (@transaction_save.account_id) == (@transaction.account_id) #Verifica se atualização ocorre na mesma conta cadastrada
      if (@transaction_save.paid == false) && (@transaction.paid == true)
        debit
      elsif (@transaction_save.paid == true) && (@transaction.paid == false)
        credit
        elsif (@transaction_save.paid == true) && (@transaction.paid == true)
        update_debit 
      end
    else #Aqui as contas são diferentes
      if (@transaction_save.paid == false) && (@transaction.paid == true)
        change_account
      elsif (@transaction_save.paid == true) && (@transaction.paid == false)
        credit
      elsif (@transaction_save.paid == true) && (@transaction.paid == true)
        debit
        credit
      end
    end
  end

  def destroy
    transacao = @transaction.description
    @transaction_save = Transaction.find(@transaction.id) #Busca no BD a Transação Existente e guarda os valores
    @account_save = Account.find(@transaction_save.account_id) #Busca a conta inicial da transação existente
    
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to site_expenses_path, notice: "A Transação (#{transacao}) foi deletada com sucesso!" }
      format.json { head :no_content }
    end

    if @transaction.paid == true
      credit
    end
  end

  private

    def debit #Debita valor de uma nova transação paid=true ou debita de uma conta que se iniciou com paid=false  
      @account_actual = Account.find(@transaction.account_id) 
      @account_actual.update(amount: @account_actual.amount - @transaction.amount)
    end

    def credit #Devolve valor pago para a conta debitada
      @account_save.update(amount: @account_save.amount + @transaction.amount)
    end

    def change_account #Transação não paga em uma conta que se torna paga em outra
      @new_account = Account.find(@transaction.account_id)
      @new_account.update(amount: @new_account.amount - @transaction.amount)
    end

    def update_debit
      if @transaction_save.amount > @transaction.amount
        @account_save.update(amount: @account_save.amount + (@transaction_save.amount - @transaction.amount))
      else
        @account_save.update(amount: @account_save.amount - (@transaction.amount - @transaction_save.amount))
      end
    end

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:member_id, :kind_transaction, :description, :amount, :date, :category_id, :account_id, :paid)
    end
end