class Format < ActiveRecord::Base
  has_many :viewings

  validates :name, presence: true
end
