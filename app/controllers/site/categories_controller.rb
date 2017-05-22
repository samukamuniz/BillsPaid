/class Site::CategoriesController < SiteController
	before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.where(member: current_member)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.member = current_member

    respond_to do |format|
      if @category.save
        format.html { redirect_to redirect_route, notice: "A Categoria (#{@category.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #redirect_route = @category.kind_transaction == 1 ? site_expense_types_path : site_income_types_path
    
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to redirect_route, notice: "A Categoria (#{@category.description}) foi atualizada com sucesso!" }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    categoria = @category.description
    @category.destroy
    respond_to do |format|
      format.html { redirect_to site_categories_path, notice: "A Categoria (#{categoria}) foi deletada com sucesso!" }
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
/