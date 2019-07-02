class Movie < ApplicationRecord
  require 'csv'
  has_many :viewings, dependent: :destroy
  accepts_nested_attributes_for :viewings,
                                reject_if: proc { |attributes| attributes['date'].blank? },
                                allow_destroy: true

  before_validation :build_title_index

  validates :title, presence: true
  validates :title_index, presence: true
  validates :director, presence: true
  validates :year, numericality: { greater_than: 1880, less_than: 2100 }
  validates :skandies_year, numericality: { greater_than: 1996, less_than: 2069 }, allow_nil: true
  validates :short, inclusion: { in: [ true, false] }
  validates :current_rating, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def display
    title + ' (' + director + ', ' + year.to_s + ")"
  end

  def display_no_date
    title + ' (' + director + ')'
  end

  def build_title_index
    self.title_index = self.title.sub(/(?i)^(The|A|An) (.*)$/,'\2, \1');
  end

  def self.search(title)
    where(title: title)
  end

  def self.import
    CSV.open('new_file_2.csv', 'wb') do |new_file|
      CSV.foreach('all_movies_with_no_viewing.csv') do |row|
        movie = Movie.where(title: row[0].strip, year: row[2].strip).first
        if movie
          new_file << row
          puts row[0].strip + ',' + row[1].strip + "," + row[2].strip + "," + row[3].strip + "," + row[4].strip
        end
      end
    end
  end

  def self.upload
    CSV.foreach('movie_upload_no_viewing.csv') do |row|
      movie = Movie.new
      movie.title = row[0]
      movie.director = row[1]
      movie.year = row[2]
      movie.current_rating = row[3]
      if row[4] == 't'
        movie.short = true
      else
        movie.short = false
      end
      movie.save
    end
  end

  def self.print_years
    CSV.foreach('all_movies_with_no_viewing.csv') do |row|
      puts row[2]
    end
  end
end
