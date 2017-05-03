class Backoffice::KindTransactionsController < BackofficeController
  before_action :set_kind_transaction, only: [:show, :edit, :update, :destroy]
  # GET /kind_transactions
  # GET /kind_transactions.json
  def index
    @kind_transactions = KindTransaction.all
  end

  # GET /kind_transactions/1
  # GET /kind_transactions/1.json
  def show
  end

  # GET /kind_transactions/new
  def new
    @kind_transaction = KindTransaction.new
  end

  # GET /kind_transactions/1/edit
  def edit
  end

  # POST /kind_transactions
  # POST /kind_transactions.json
  def create
    @kind_transaction = KindTransaction.new(kind_transaction_params)

    respond_to do |format|
      if @kind_transaction.save
        format.html { redirect_to backoffice_kind_transactions_path, notice: "O Tipo de Transação (#{@kind_transaction.description}) foi salvo com sucesso!" }
        format.json { render :show, status: :created, location: @kind_transaction }
      else
        format.html { render :new }
        format.json { render json: @kind_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kind_transactions/1
  # PATCH/PUT /kind_transactions/1.json
  def update
    respond_to do |format|
      if @kind_transaction.update(kind_transaction_params)
        format.html { redirect_to backoffice_kind_transactions_path, notice: "O Tipo de Transação (#{@kind_transaction.description}) foi atualizado com sucesso!" }
        format.json { render :show, status: :ok, location: @kind_transaction }
      else
        format.html { render :edit }
        format.json { render json: @kind_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kind_transactions/1
  # DELETE /kind_transactions/1.json
  def destroy
    @kind_transaction.destroy
    respond_to do |format|
      format.html { redirect_to kind_transactions_url, notice: 'Kind transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind_transaction
      @kind_transaction = KindTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kind_transaction_params
      params.require(:kind_transaction).permit(:description)
    end
end

