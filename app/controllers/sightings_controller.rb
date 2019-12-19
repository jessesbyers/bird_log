class SightingsController < ApplicationController

  get '/sightings' do
    @users = User.all
    if Helpers.logged_in?(session)
      erb :'sightings/index'
    else
      redirect '/'
    end
  end

  get '/sightings/new' do
    if Helpers.logged_in?(session)
      erb :'sightings/new'
    else
      redirect to '/'
    end
  end

  post '/sightings' do
    if params[:audubon_url] != "" && params[:audubon_url].include?("https://www.audubon.org/field-guide/bird/")
      @sighting = Sighting.new(:audubon_url => params[:audubon_url], :date => params[:date], :location => params[:location], :notes => params[:notes], :user_id => Helpers.current_user(session).id)
      bird_attributes = Bird.scrape_attributes(@sighting.audubon_url)

      if bird_attributes == nil
        redirect to "/sightings/new"
      else
        bird = Bird.find_or_create_by(bird_attributes)
        @sighting.bird_id = bird.id
        @sighting.save

        redirect to "/sightings/#{@sighting.id}"
      end
    else
      redirect to "/sightings/new"
    end
  end

  get '/sightings/:id' do
    if Helpers.logged_in?(session)
       @sighting = Sighting.find_by_id(params[:id])
       erb:'sightings/show'
     else
       redirect to '/sightings'
     end
  end

  get '/sightings/:id/edit' do
    if Helpers.logged_in?(session)
       @sighting = Sighting.find_by_id(params[:id])
       erb :'sightings/edit'
     else
       redirect to '/'
     end
   end

  patch '/sightings/:id' do
    if Helpers.logged_in?(session)
      @sighting = Sighting.find_by_id(params[:id])
      @sighting.date = params[:date]
      @sighting.location = params[:location]
      @sighting.notes = params[:notes]
      @sighting.user_id = Helpers.current_user(session).id
      @sighting.save
      redirect to "/sightings/#{@sighting.id}"
    else
      redirect to '/'
    end
  end

  delete '/sightings/:id/delete' do
    if Helpers.logged_in?(session)
      @sighting = Sighting.find_by_id(params[:id])
      if @sighting.user_id == Helpers.current_user(session).id
        if @sighting.bird.sightings.count == 1
          @sighting.delete
          @sighting.bird.delete
        else
          @sighting.delete
        end
        redirect to '/users'
      end
    else
      redirect to '/'
    end
  end
end
