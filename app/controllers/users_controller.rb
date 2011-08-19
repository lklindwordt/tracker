class UsersController < ApplicationController
  layout "login"
  
  def new 
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path, :notice => "Signed up!"
    else
      render "new"
    end
  end
end