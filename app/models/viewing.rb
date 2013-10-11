class Viewing < ActiveRecord::Base
  belongs_to :movie
  belongs_to :format

  # validates :movie_id, presence: true
  validates :date, presence: true
  validates :format_id, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
