class FiguresController < ApplicationController

  get '/figures' do
    #show all figures
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    #create a new figure
    @figures = Figure.all
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    #see a single figure
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    #create a new figure
    @figure = Figure.create(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    #edit a single figure
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    #edit a single figure
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
