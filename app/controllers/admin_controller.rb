class AdminController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end
end
