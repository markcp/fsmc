class Movie < ActiveRecord::Base
  has_many :viewings, dependent: :destroy
  accepts_nested_attributes_for :viewings,
                                reject_if: proc { |attributes| attributes['date'].blank? },
                                allow_destroy: true

  before_validation :build_title_index

  validates :title, presence: true
  validates :title_index, presence: true
  validates :director, presence: true
  validates :year, numericality: { greater_than: 1880, less_than: 2100 }
  validates :skandies_year, numericality: { greater_than: 1999, less_than: 2069 }, allow_nil: true
  validates :short, inclusion: { in: [ true, false] }
  validates :current_rating, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def build_title_index
    self.title_index = self.title.sub(/(?i)^(The|A|An) (.*)$/,'\2, \1');
  end

  def self.search(title)
    where(title: title)
  end

  def display
    title + " (" + director + ", " + year.to_s + ") " + current_rating.to_s
  end
end
