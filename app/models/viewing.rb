class Viewing < ActiveRecord::Base
  belongs_to :movie
  belongs_to :format

  # validates :movie_id, presence: true
  validates :date, presence: true
  validates :format_id, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  default_scope { order('date DESC') }

  def display_format
    date.strftime("%d %b") + ". " + movie.title + " (" + movie.director + ", " + movie.year.to_s + ") "
  end

  def is_repeat_viewing?
    movie.viewings.length > 1 && id != movie.viewings[0].id
  end

  def is_on_film?
    format.name == "Film"
  end

  def is_on_blu_ray?
    format.name == "Blu-ray disc"
  end

  def is_on_dvd?
    format.name == "DVD"
  end

  def is_on_dcp?
    format.name == "DCP"
  end
end
