class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def edit
    client_id = 'e5b765e6ce409b1727a6'
    client_secret = '2b8abb6c548ffb70c17cca09746c43606c15f8c3'
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?
      client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    pairs = response.body.split('&')
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split('=')
      response_hash[key] = value
    end

    token = response_hash['access_token']
    if token != nil
      current_user.update_attribute(:token, token)
    end
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
