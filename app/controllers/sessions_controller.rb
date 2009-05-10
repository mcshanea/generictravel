# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end

  def create
    self.current_user = Agent.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      
      # If this user doesn't have a company_id then they must be a super-admin
      if current_user.company_id
        session[:company] = Company.find(current_user.company_id)
      end
        
      flash[:notice] = "Logged in successfully"
    else
      flash[:error] = "Authentication Failed."
      
      user_check = Agent.find_by_login(params[:login])
      
      if (!user_check.nil? && user_check.active == false)
        p "trying something"
        
        flash[:error] = "User not active. Please contact your company administrator."
      end

      render :action => 'new'
    end
  end
  
  def edit
    password = generate_password
    
    user = Agent.find_by_login(params[:login])
    
    if user.nil?
      flash[:error] = "Login not found"
    else
      #user.password = password
      
      MailMe.deliver_reminder(user.email, password)
      
      flash[:notice] = "New password sent to your email address"
    end
    
    render :action => 'new'
  end
  
  def generate_password(length=6)  
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'  
    password = ''  
    length.times { |i| password << chars[rand(chars.length)] }  
    password  
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
