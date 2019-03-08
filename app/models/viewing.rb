class Viewing < ActiveRecord::Base
  require 'csv'

  belongs_to :movie
  belongs_to :format

  # validates :movie_id, presence: true
  validates :date, presence: true
  validates :format_id, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  default_scope { order('date DESC') }

  def date_display_format
    date.strftime("%d %b") + ". "
  end

  def director_and_year_display_format
    " (" + movie.director + ", " + movie.year.to_s + ") "
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

  def self.create_letterboxd_upload_file
    CSV.foreach('movies_import.csv') do |row|

    end
  end

  def self.pull_from_file
    CSV.foreach('movies_import.csv') do |row|
      movie = Movie.where(title: row[1].strip, year: row[3].strip).first
      if movie
        puts "movie "
        viewing = Viewing.new
        viewing.movie_id = movie.id
        viewing.date = Viewing.date_from_string(row[0].strip)
        if row[7] == 'f'
          viewing.format_id = 7
        elsif row[7] == 'p'
          viewing.format_id = 6
        elsif row[7] == 'v'
          viewing.format_id = 8
        elsif row[7] == 'c'
          viewing.format_id = 2
        else
          viewing.format_id = 3
        end
        viewing.rating = row[4].strip
        viewing.save
      else
        puts "no movie"
        movie = Movie.new
        movie.title = row[1].strip
        movie.director = row[2].strip
        movie.year = row[3].strip
        movie.current_rating = row[4].strip
        if row[5] && row[5].strip == 's'
          movie.short = true
        else
          movie.short = false
        end
        if row[6]
          puts "in row 6"
          movie.skandies_year = row[6].strip
          puts "row 6" + row[6].strip.to_s
        end
        movie.save
        viewing = Viewing.new
        puts "row[0]" + row[0]
        viewing.movie_id = movie.id
        viewing.date = Viewing.date_from_string(row[0].strip)
        if row[7] == 'f'
          viewing.format_id = 7
        elsif row[7] == 'p'
          viewing.format_id = 6
        elsif row[7] == 'v'
          viewing.format_id = 8
        elsif row[7] == 'c'
          viewing.format_id = 2
        else
          viewing.format_id = 3
        end
        viewing.rating = row[4].strip
        viewing.save
      end
    end
  end

  def self.date_from_string(date_string)
    Date.strptime(date_string, "%Y-%m-%d")
  end
end
