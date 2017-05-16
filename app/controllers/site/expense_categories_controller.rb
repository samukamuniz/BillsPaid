class Site::ExpenseCategoriesController < SiteController
  before_action :set_expense_category, only: [:edit, :update, :destroy]

  def index
    @expense_categories = Category.where(kind_transaction: 1, member: current_member)
  end

  def new
    @expense_category = Category.new
  end

  def edit
  end

  def create
    @expense_category = Category.new(expense_category_params)
    @expense_category.member = current_member
    @expense_category.kind_transaction = 1

    respond_to do |format|
      if @expense_category.save
        format.html { redirect_to site_expense_categories_path, notice: "A Categoria (#{@expense_category.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @expense_category }
      else
        format.html { render :new }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense_category.update(expense_category_params)
        format.html { redirect_to site_expense_categories_path, notice: "A Categoria (#{@expense_category.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @expense_category }
      else
        format.html { render :edit }
        format.json { render json: @expense_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    categoria = @expense_category.description
    @expense_category.destroy
    respond_to do |format|
      format.html { redirect_to site_expense_categories_path, notice: "A Categoria (#{categoria}) foi deletada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_category
      @expense_category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_category_params
      params.require(:category).permit(:kind_transaction, :member_id, :description)
    end

end