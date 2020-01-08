class UsersController < ApplicationController

  get '/signup' do
    redirect_already_logged_in
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save
      session[:user_id] = @user.id
      redirect "/users"
    end
    redirect "/failure"
  end

  get '/login' do
    redirect_already_logged_in
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/users'
    else
      redirect '/'
    end
  end

  get "/users" do
    redirect_not_logged_in
    @user = Helpers.current_user(session)
    erb :'users/show'
  end

  get '/logout' do
    redirect_not_logged_in
    session.clear
    redirect '/'
  end

  get '/failure' do
    erb :'users/failure'
  end
end
