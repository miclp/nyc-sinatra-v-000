class LandmarksController < ApplicationController

  ###
    get '/landmarks' do
      erb :'/landmarks/index'
    end

    get '/landmarks/new' do
      #create a landmark and post to /landmarks
      erb :'/landmarks/new'
    end

    post '/landmarks' do

      # binding.pry
      if Landmark.find_by(name: params[:landmark][:name])
        redirect '/landmarks/error'
      end

      # Landmark name
      if !params[:landmark][:name].blank?
        # create the landmark
        @landmark = Landmark.create(name: params[:landmark][:name])
      else
        redirect '/landmarks/error'
      end

      if !params[:figure][:name].empty?
        @landmark.figure = Figure.find_or_create_by(name: params[:figure][:name])
      elsif !params[:landmark][:figure_id].blank?
        @landmark.figure = Figure.find(params[:landmark][:figure_id])
      end

      @landmark.year_completed = params[:landmark][:year_completed]
      @landmark.save
      #
      # # show the landmark based on id
      redirect "/landmarks/#{@landmark.id}"
    end

    get '/landmarks/error' do
      erb :'/error'
    end

    get '/landmarks/:id' do
      # show a landmark based on id
      @landmark = Landmark.find(params[:id])
      erb :'/landmarks/show'
    end

    get '/landmarks/:id/edit' do
      # edit landmark
      @landmark = Landmark.find(params[:id])
      # binding.pry
      erb :'/landmarks/edit'
    end

    patch '/landmarks/:id/edit' do
      # update the song and save it
      @landmark = Landmark.find(params[:id])

      # Update the landmark name
      @landmark.name = params[:landmark][:name]

      if params[:figure][:name].empty?
        @landmark.figure = Figure.find(params[:landmark][:figure_id])
      else
        @landmark.figure = Figure.find_or_create_by(name: params[:figure][:name])
      end

      @landmark.year_completed = params[:landmark][:year_completed]

      @landmark.save
      # redirect to the landmark's show page
      redirect "/landmarks/#{@landmark.id}"
    end

end
