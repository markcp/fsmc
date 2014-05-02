class MoviesController < ApplicationController
  before_action :signed_in_user, except: [ :skandies_by_rating, :skandies_by_title, :all_by_rating, :all_by_title, :all_by_year ]

  def skandies_by_rating
    if params[:year]
      @year = params[:year]
    else
      @year = Time.now.year.to_s
    end
    @movies = Movie.where(skandies_year: @year).order("current_rating DESC").all
  end

  def skandies_by_title
    if params[:year]
      @year = params[:year]
    else
      @year = Time.now.year.to_s
    end
    @movies = Movie.where(skandies_year: @year).order("title").all
  end

  def all_by_rating
    @movies = Movie.all.order("current_rating DESC")
  end

  def all_by_title
    @movies = Movie.all.order("title")
  end

  def all_by_year
    @movies = Movie.all.order("year, current_rating DESC")
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
    @formats = Format.all
  end

  def create
    build_current_rating

    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to @movie
    else
      @formats = Format.all
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    @movie.viewings.build
    @formats = Format.all
  end

  def update
    build_current_rating
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :director, :year, :skandies_year,
                                    :short, :current_rating, viewings_attributes:
                                    [:id, :date, :format_id, :rating, :note, :_destroy])
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def build_current_rating
      # if current rating not provided, use rating from latest viewing
      # we don't know latest viewing, so take last non-blank rating attribute in form
      # this won't work if a film is logged more than 11 times
      for i in 0..10
        if params[:movie][:viewings_attributes][i.to_s]
          if params[:movie][:viewings_attributes][i.to_s][:rating] != ""
            params[:movie][:current_rating] = params[:movie][:viewings_attributes][i.to_s][:rating]
          end
        end
      end
    end
end
