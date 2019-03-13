class Format < ApplicationRecord
  has_many :viewings

  validates :name, presence: true
end
