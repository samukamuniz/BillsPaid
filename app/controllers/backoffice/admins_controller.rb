class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]

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
    pwd = params[:admin][:password]
    pwd_confirm = params[:admin][:password_confirmation]

    if pwd.blank? && pwd_confirm.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(admins_params)
      redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi atualizado com sucesso!"
    else
	    render :edit
    end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "O Administrador (#{admin_email}) foi excluído com sucesso!"
    else
      rende :index
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