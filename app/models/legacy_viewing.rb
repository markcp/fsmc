class LegacyViewing < ActiveRecord::Base
  establish_connection :fsmc_legacy

  self.table_name = 'viewings'

  belongs_to :legacy_movie, foreign_key: :movie_id

  def format
    case medium
    when 'd'
      3
    when 'f'
      7
    when 'v'
      8
    when 'p'
      6
    end
  end

end
