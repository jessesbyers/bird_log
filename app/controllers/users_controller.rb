class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/users"
    else
      erb :'users/signup'
    end
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
    if Helpers.logged_in?(session)
      redirect '/users'
    else
      erb :'users/login'
    end
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
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'users/show'
    else
      redirect '/'
    end
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/failure' do
    erb :'users/failure'
  end
end
