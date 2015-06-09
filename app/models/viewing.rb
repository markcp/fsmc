class Viewing < ActiveRecord::Base
  require 'csv'

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

  def self.pull_from_file
    movie_doesnt_exist = 0
    CSV.foreach('movies.csv') do |row|
      movie = Movie.where(title: row[1].strip, year: row[3].strip).first
      if movie
        viewing = Viewing.new
        viewing.movie_id = movie.id
        viewing.date = Viewing.date_from_string(row[0])
      else
        movie_doesnt_exist = movie_doesnt_exist + 1
      end
    end
    puts movie_doesnt_exist.to_s
  end

  def self.date_from_string(date_string)
    Date.strptime(date_string + " 1998", "%d %b %Y")
  end
end
