class FiguresController < ApplicationController
###
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    #create a figure and post to /figures
    erb :'/figures/new'
  end

  post '/figures' do
    # create the figure
    # binding.pry
    if Figure.find_by(name: params[:figure][:name])
      redirect '/figures/error'
    end

    @figure = Figure.create(name: params[:figure][:name])

    # compile all the landmarks
    landmarks = []
    if params[:figure].key?("landmark_ids")  # check if it's not nil
      if !params[:figure][:landmark_ids].empty?
        params[:figure][:landmark_ids].each do |landmark_id|
          landmarks << Landmark.find(landmark_id)
        end
      end
    end

    if !params[:landmark][:name].empty?  # it will exist as "" but might be empty
      landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      if !landmarks.include?(landmark)
        landmarks << landmark
      end
    end
    @figure.landmarks = landmarks

    #### Titles ####
    # compile all the titles
    titles = []
    if params[:figure].key?("title_ids")  # check if it's not nil
      if !params[:figure][:title_ids].empty?
        params[:figure][:title_ids].each do |title_id|
          titles << Title.find(title_id)
        end
      end
    end

    if !params[:title][:name].empty?  # it will exist as "" but might be empty
      title = Title.find_or_create_by(name: params[:title][:name])
      if !titles.include?(title)
        titles << title
      end
    end
    @figure.titles = titles

    #### End Titles ####
    @figure.save

    # show the figure based on id
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/error' do
    erb :'/error'
  end

  get '/figures/:id' do
    # show a figure based on id
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    # edit figure
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id/edit' do
    # update the song and save it
    @figure = Figure.find(params[:id])
    # binding.pry

    # Update the figure name
    @figure.name = params[:figure][:name]

    # compile all the landmarks
    landmarks = []
    if params[:figure].key?("landmark_ids")  # check if it's not nil
      if !params[:figure][:landmark_ids].empty?
        params[:figure][:landmark_ids].each do |landmark_id|
          landmarks << Landmark.find(landmark_id)
        end
      end
    end

    if !params[:landmark][:name].empty?  # it will exist as "" but might be empty
      landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      if !landmarks.include?(landmark)
        landmarks << landmark
      end
    end
    @figure.landmarks = landmarks

    #### Titles ####
    # compile all the titles
    titles = []
    if params[:figure].key?("title_ids")  # check if it's not nil
      if !params[:figure][:title_ids].empty?
        params[:figure][:title_ids].each do |title_id|
          titles << Title.find(title_id)
        end
      end
    end

    if !params[:title][:name].empty?  # it will exist as "" but might be empty
      title = Title.find_or_create_by(name: params[:title][:name])
      if !titles.include?(title)
        titles << title
      end
    end
    @figure.titles = titles

    #### End Titles ####
    @figure.save

    # redirect to the song's show page
    redirect "/figures/#{@figure.id}"
  end
end
