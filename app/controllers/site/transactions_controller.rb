class Site::TransactionsController < SiteController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = Transaction.where(member_id: current_member, paid: true).order('date DESC')
  end

  def new
    @transaction = Transaction.new
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)
       
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

  def update

    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to site_transactions_path, notice: "A Transação (#{@transaction.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

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
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:member_id, :kind_transaction, :description, :amount, :date, :category_id, :account_id, :paid)
    end
end