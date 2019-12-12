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
    if params[:audubon_url] != ""
      @sighting = Sighting.create(:audubon_url => params[:audubon_url], :date => params[:date], :location => params[:location], :notes => params[:notes], :user_id => Helpers.current_user(session).id)

      new_bird = Bird.new(Bird.scrape_attributes(@sighting.audubon_url))
      # if Bird.all.include?(bird.common_name)

      Bird.all.each do |bird|
        if bird.common_name.match?(new_bird.common_name)
          @sighting.bird_id = Bird.find_by(common_name: new_bird.common_name).id
          new_bird.delete
        else
          new_bird.save
          @sighting.bird_id = bird.id
        end
      end

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
       redirect to '/login'
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
      # if params[:audubon_url] == ""
      #   redirect "/sightings/#{@sighting.id}/edit"
      # else
        @sighting.audubon_url = params[:audubon_url]
        @sighting.date = params[:date]
        @sighting.location = params[:location]
        @sighting.notes = params[:notes]
        @sighting.user_id = Helpers.current_user(session).id
        # @sighting.bird_id = #need to figure out later
        @sighting.save
        redirect to "/sightings/#{@sighting.id}"
      # end
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
