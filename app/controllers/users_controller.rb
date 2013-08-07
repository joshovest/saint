class UsersController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:success] = 'Account for ' + params[:user][:name] + ' has been successfully created.'
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if current_user == @user
        sign_in @user
      end
      flash[:success] = 'Account for ' + params[:user][:name] + ' has been successfully updated.'
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'Account for ' + @user.name + ' has been successfully deleted.'
    redirect_to users_path
  end
end
