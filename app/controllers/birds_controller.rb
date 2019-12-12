class BirdsController < ApplicationController

  get '/birds' do
    @birds = Bird.all
    if Helpers.logged_in?(session)
      erb :'birds/index'
    else
      redirect '/login'
    end
  end

  get '/birds/:id' do
    if Helpers.logged_in?(session)
       @bird = Bird.find(params[:id])
       erb:'birds/show'
     else
       redirect to '/login'
     end
  end
end
