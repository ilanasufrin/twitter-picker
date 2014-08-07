class SessionsController < ApplicationController
  def new
    redirect_to '/auth/twitter'
  end

  def create
    binding.pry
    @user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || User.create_from_omniauth(auth_hash)
    if @user
      session[:user_id] = @user.id
      redirect_to campaigns_path
    else
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
