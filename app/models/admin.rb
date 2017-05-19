class Admin < ActiveRecord::Base
	enum role: [:full_access, :restricted_acess]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #enum role: ROLES
  #scope :with_full_acess, -> {where(role: ROLES[:full_access])}
  #scope :with_restricted_acess, -> {where(role: ROLES[:restricted_acess])}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role_br
  	if self.role == 'full_access'
  		'Acesso Completo'
  	else
  		'Acesso Restrito'
  	end
  end
end
