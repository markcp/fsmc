class Movie < ActiveRecord::Base
  has_many :viewings

  before_validation :build_title_index

  validates :title, presence: true
  validates :title_index, presence: true
  validates :director, presence: true
  validates :year, numericality: { greater_than: 1969, less_than: 2069 }
  validates :skandies_year, numericality: { greater_than: 1999, less_than: 2069 }, allow_nil: true
  validates :short, inclusion: { in: [ true, false] }

  def build_title_index
    self.title_index = self.title.sub(/(?i)^(The|A|An) (.*)$/,'\2, \1');
  end
end
