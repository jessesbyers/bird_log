class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/sightings"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect "/sightings"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/sightings'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/sightings'
    else
      redirect '/login'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end
end
