class SightingsController < ApplicationController

  get '/sightings' do
    @users = User.all
    redirect_not_logged_in
    erb :'sightings/index'
  end

  get '/sightings/new' do
    redirect_not_logged_in
    @birds = Bird.all
    @sightings = Sighting.all
    erb :'sightings/new'
  end

  post '/sightings' do
    # if existing bird is chosen
    if params.has_key?("bird")
      params[:audubon_url] = ""
      @sighting = Sighting.new(:date => params[:date], :notes => params[:notes], :user_id => Helpers.current_user(session).id)
      existing_bird = Bird.find_by(:id => params[:bird][:bird_id])
      @sighting.bird = existing_bird
      @sighting.audubon_url = existing_bird.sightings.first.audubon_url
      @sighting.save

    # if bird is chosen by url
    elsif params[:audubon_url] != "" && params[:audubon_url].include?("https://www.audubon.org/field-guide/bird/")
      @sighting = Sighting.new(:audubon_url => params[:audubon_url], :date => params[:date], :notes => params[:notes], :user_id => Helpers.current_user(session).id)
      bird_attributes = Bird.scrape_attributes(@sighting.audubon_url)

      if bird_attributes == nil
        redirect to "/sightings/new"
      else
        bird = Bird.find_or_create_by(bird_attributes)
        @sighting.bird_id = bird.id
        @sighting.save

        # redirect to "/sightings/#{@sighting.id}"
      end
    else
      redirect to "/sightings/new"
    end

    # logic for assigning location to sighting (need to remove locations from above)
    if params.has_key?("sighting")
      @sighting.update(:location => params[:sighting][:location])
      redirect to "/sightings/#{@sighting.id}"
    else
      @sighting.update(:location => params[:location])
      redirect to "/sightings/#{@sighting.id}"
    end
  end

  get '/sightings/:id' do
    @sighting = Sighting.find_by_id(params[:id])
    redirect_not_logged_in
    erb:'sightings/show'
  end

  get '/sightings/:id/edit' do
    @sighting = Sighting.find_by_id(params[:id])
    @sightings = Sighting.all
    redirect_not_current_user
    erb :'sightings/edit'
  end

  patch '/sightings/:id' do
    @sighting = Sighting.find_by_id(params[:id])
    redirect_not_current_user
    if params.has_key?("sighting")
      @sighting.update(:date => params[:date], :notes => params[:notes], :location => params[:sighting][:location])
      redirect to "/sightings/#{@sighting.id}"
    else
      @sighting.update(:date => params[:date], :notes => params[:notes], :location => params[:location])
      redirect to "/sightings/#{@sighting.id}"
    end
  end

  delete '/sightings/:id/delete' do
    @sighting = Sighting.find_by_id(params[:id])
    if Helpers.logged_in?(session) && @sighting.user_id == Helpers.current_user(session).id
        if @sighting.bird.sightings.count == 1
          @sighting.delete
          @sighting.bird.delete
        else
          @sighting.delete
        end
      redirect to '/users'
    else
      redirect to '/sightings'
    end
  end
end
