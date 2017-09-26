class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@all_ratings = ['G','PG','PG-13','R','NC-17'];
    #@selected = ['G','PG','PG-13','R','NC-17
    
    @all_ratings = Movie.ratings
    @movies = Movie.all
    @selected = @all_ratings
    
    if params[:ratings]
        @selected = params[:ratings].keys
        @movies = @movies.where(:rating => @selected)
    end
    
    if params[:title] == "sort"
        @movies = @movies.order(:title => "ASC")
    elsif params[:release_date] == "sort"
        @movies = @movies.order(:release_date => "ASC")
    else
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
