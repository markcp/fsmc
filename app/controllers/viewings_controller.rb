class ViewingsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @viewing = Viewing.new
    if params[:movie_id]
      @movie = Movie.find(params[:movie_id])
    elsif params[:movie_title]
      @movie = Movie.new(title: params[:movie_title])
    else
      @movie = Movie.new
    end
  end

  def create
    @movie = Movie.new()
    @viewing = Viewing.new(viewing_params)

    if @viewing.save
      redirect_to @viewing
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def viewing_params
      params.require(:viewing).permit(:date, :format_id, :rating, :notes, movie_attributes: [:id, :title, :director, :year, :skandies_year, :short])
    endo

    def movie_params
      params.require(:movie).permit(:title, :director, :year, :skandies_year, :short)
    end
end
