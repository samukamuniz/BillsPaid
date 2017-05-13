class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admins_params)
      if @admin.save
        redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi salvo com sucesso!"  
      else
        render :new
      end
  end

  def update
      if @admin.update(admins_params)
        redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi atualizado com sucesso!"
      else
  	    render :edit
      end
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admins_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end