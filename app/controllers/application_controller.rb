require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'/users/index'
  end


  helpers do

    def logged_in?(session)
      !!session[:user_id]
    end
  
    def current_user(session)
      User.find(session[:user_id])
    end

    def redirect_already_logged_in
      if logged_in?(session)
        redirect '/users'
      end
    end

    def redirect_not_logged_in
      if !logged_in?(session)
        redirect '/'
      end
    end

    def redirect_not_current_user
      if !logged_in?(session) || !@sighting.user_id == current_user(session).id
        redirect '/'
      end
    end

    # def redirect_already_logged_in
    #   if Helpers.logged_in?(session)
    #     redirect '/users'
    #   end
    # end

    # def redirect_not_logged_in
    #   if !Helpers.logged_in?(session)
    #     redirect '/'
    #   end
    # end

    # def redirect_not_current_user
    #   if !Helpers.logged_in?(session) || !@sighting.user_id == Helpers.current_user(session).id
    #     redirect '/'
    #   end
    # end
  end
end
