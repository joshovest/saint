class SessionsController < ApplicationController
  skip_before_filter :signed_in_user
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      flash[:success] = "You have signed in."
      redirect_back_or users_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "You have signed out."
    redirect_to new_session_path
  end
end
