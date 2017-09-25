class LandmarksController < ApplicationController

  get '/landmarks' do
    #show all landmarks
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    #create a new landmark
    @landmarks = Landmark.all
    @figures = Figure.all
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    #see a single figure
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    #create a new landmark
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.find_or_create_by(name: params["figure"]["name"])
    end
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id/edit' do
    #edit a single landmark
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    #edit a single landmark
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.find_or_create_by(name: params["figure"]["name"])
    end
    @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

end
