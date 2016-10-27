class SessionsController < ApplicationController
  before_action :skip_if_logged_in, except: [:destroy]
  
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = 'Login successfully.'
        redirect_to root_path
      else
        flash[:error] = 'Incorrect password.'
        render 'new'
      end
    else
      flash[:error] = 'User not found.'
      puts 'User not found.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout successfully.'
    redirect_to login_path
  end
end
