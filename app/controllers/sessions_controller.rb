class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    else
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
