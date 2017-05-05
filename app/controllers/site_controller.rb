class SiteController < ApplicationController
  before_action :authenticate_member!
  layout "site"
end