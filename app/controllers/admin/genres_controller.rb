class Admin::GenresController < ApplicationController
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(prams[:id])
    if genre.update(params[:name])
      redirect_to :index
    else
      @genre = Genre.find(params[:id])
      render :edit
      ene
  end
  
  def create
    genre = Genre.new(params[:name])
    if genre.save
      redirect_to :index
    else
      @genres = Genre.all
      render :index
    end
  end
  
end
