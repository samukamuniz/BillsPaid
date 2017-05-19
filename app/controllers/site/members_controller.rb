class Site::MembersController < SiteController
	before_action :set_member, only: [:new,:create,:edit, :update]
  
  def new
    @member = Member.new
  end

  def edit
  end
  
  def create
    @member = Admin.new(members_params)
    if @member.save
      redirect_to site_home_path, notice: "<b>#{@member.name}</b>, seu usuário foi criado com sucesso!"  
    else
      render :new
    end
  end

  def update
    pwd = params[:member][:password]
    pwd_confirm = params[:member][:password_confirmation]

    if pwd.blank? && pwd_confirm.blank?
      params[:member].delete(:password)
      params[:member].delete(:password_confirmation)
    end

    if @member.update(member_params)
      redirect_to site_home_path, notice: "<b>#{@member.name}</b>, seus dados foram atualizados com sucesso!"
    else
	    render :edit
    end
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

  def members_params
    params.require(:member).permit(:name, :email, :password, :password_confirmation)
  end
end
