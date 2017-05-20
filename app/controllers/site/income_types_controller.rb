class Site::IncomeTypesController < Site::CategoriesController 
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.where(kind_transaction: 2, member: current_member)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.member = current_member
    @category.kind_transaction = 2
    puts "****************************************************************************************************"
    puts "****************************************************************************************************"
    puts "Estou passando por aqui income_types_create"
    puts "****************************************************************************************************"
    puts "****************************************************************************************************"
    respond_to do |format|
      if @category.save
        format.html { redirect_to site_income_types_path, notice: "A Categoria (#{@category.description}) foi salva com sucesso!" }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    tipoReceita = @category.description
    @category.destroy
    respond_to do |format|
      format.html { redirect_to site_income_types_path, notice: "A Categoria (#{tipoReceita}) foi deletada com sucesso!" }
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