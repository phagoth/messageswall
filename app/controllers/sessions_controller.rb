class SessionsController < ApplicationController

  def create
    user = find_or_create_from_auth_hash(auth_hash)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
  
  protected

    def auth_hash
      request.env['omniauth.auth']
    end

end