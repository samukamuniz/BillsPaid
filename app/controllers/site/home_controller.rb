class Site::HomeController < SiteController 
  def index
  	#@receitas = Account.sum("amount", member: current_member)
  	@receitas = Account.where(member: current_member).sum("amount_cents")
  end
end
