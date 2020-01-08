class BirdsController < ApplicationController

  get '/birds' do
    @birds = Bird.all
    redirect_not_logged_in
    erb :'birds/index'
  end

  get '/birds/:id' do
    @bird = Bird.find(params[:id])
    redirect_not_logged_in
    erb:'birds/show'
  end
end
