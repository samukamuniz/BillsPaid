class Site::ExpenseTypesController < SiteController
  before_action :set_expense_type, only: [:edit, :update, :destroy]

  def index
    @expense_types = Category.where(kind_transaction: 1, member: current_member)
  end

  def new
    @expense_type = Category.new
  end

  def edit
  end

  def create
    @expense_type = Category.new(expense_type_params)
    @expense_type.member = current_member
    @expense_type.kind_transaction = 1

    respond_to do |format|
      if @expense_type.save
        format.html { redirect_to :index, notice: "A Categoria (#{@expense_type.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @expense_type }
      else
        format.html { render :new }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense_type.update(expense_type_params)
        format.html { redirect_to site_expense_types_path, notice: "A Categoria (#{@expense_type.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @expense_type }
      else
        format.html { render :edit }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    tipoDespesa = @expense_type.description
    @expense_type.destroy
    respond_to do |format|
      format.html { redirect_to site_expense_types_path, notice: "A Categoria (#{tipoDespesa}) foi deletada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_type
      @expense_type = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_type_params
      params.require(:expense_type).permit(:kind_transaction, :member_id, :description)
    end
end
