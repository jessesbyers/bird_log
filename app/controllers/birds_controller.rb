class BirdsController < ApplicationController

  get '/birds' do
    @birds = Bird.all
    if Helpers.logged_in?(session)
      erb :'birds/index'
    else
      redirect '/login'
    end
  end
end
