class MoviesController < ApplicationController
  def index
  end

  def search
    if params[:title]
      @movies = Movie.search(params[:title]).to_a
      if @movies.length == 0
        redirect_to new_movie_path(title: params[:title])
      end
    end
  end

  def new
    @movie = Movie.new(title: params[:title])
    @movie.viewings.build
  end

  def create
    # if current_rating form field is blank, move viewing rating
    # to movie's current_rating field
    if params[:movie][:current_rating] == ""
      params[:movie][:current_rating] = params[:movie][:viewings_attributes]["0"][:rating]
    end

    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :director, :year, :skandies_year, :short, :current_rating, viewings_attributes: [:date, :format_id, :rating, :notes])
    end
end
