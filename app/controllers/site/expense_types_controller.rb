class Site::ExpenseTypesController < SiteController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.where(kind_transaction: 'expenses', member_id: current_member )
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.kind_transaction = 0
    @category.member_id = current_member

    respond_to do |format|
      if @category.save
        format.html { redirect_to site_expense_types_path, notice: "A Categoria (#{@category.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to site_expense_types_path, notice: "A Categoria (#{@category.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    categoria = @category.description
    @category.destroy
    respond_to do |format|
      format.html { redirect_to site_expense_types_path, notice: "A Categoria (#{categoria}) foi deletada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:kind_transaction, :member_id, :description)
    end
end