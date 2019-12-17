class SightingsController < ApplicationController

  get '/sightings' do
    @users = User.all
    if Helpers.logged_in?(session)
      erb :'sightings/index'
    else
      redirect '/login'
    end
  end

  get '/sightings/new' do
    if Helpers.logged_in?(session)
      erb :'sightings/new'
    else
      redirect to '/login'
    end
  end

  post '/sightings' do
    if params[:audubon_url] != "" && params[:audubon_url].include?("https://www.audubon.org/field-guide/bird/")
      @sighting = Sighting.new(:audubon_url => params[:audubon_url], :date => params[:date], :location => params[:location], :notes => params[:notes], :user_id => Helpers.current_user(session).id)
      bird = Bird.find_or_create_by(Bird.scrape_attributes(@sighting.audubon_url))
      @sighting.bird_id = bird.id
      @sighting.save

      redirect to "/sightings/#{@sighting.id}"
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
       redirect to '/login'
     end
   end

  patch '/sightings/:id' do
    if Helpers.logged_in?(session)
      @sighting = Sighting.find_by_id(params[:id])
      if params[:audubon_url] == ""
        redirect "/sightings/#{@sighting.id}/edit"
      else
        @sighting.audubon_url = params[:audubon_url]
        @sighting.date = params[:date]
        @sighting.location = params[:location]
        @sighting.notes = params[:notes]
        @sighting.user_id = Helpers.current_user(session).id
        @sighting.save
        redirect to "/sightings/#{@sighting.id}"
      end
    else
      redirect to '/login'
    end
  end

  delete '/sightings/:id/delete' do
    if Helpers.logged_in?(session)
      @sighting = Sighting.find_by_id(params[:id])
      if @sighting.user_id == Helpers.current_user(session).id
        @sighting.delete
        redirect to '/sightings'
      end
    else
      redirect to '/login'
    end
  end
end
