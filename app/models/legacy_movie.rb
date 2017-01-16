class LegacyMovie < ActiveRecord::Base
  establish_connection :fsmc_legacy

  self.table_name = 'movies'

  has_many :legacy_viewings, foreign_key: :movie_id

  def title
    regexp = /, (The|A|An)$/
    if title_eng =~ regexp
      $1 + " " + title_eng.gsub(regexp, "")
    else
      title_eng
    end
  end

  def director
    if director_other != ""
      (director_first + " " + director_last + ", " + director_other).strip
    else
      (director_first + " " + director_last).strip
    end
  end

  def short_boolean
    if short == 's'
      true
    else
      false
    end
  end

  def self.convert_movies
    LegacyMovie.all.each do |lm|
      m = Movie.new
      m.title = lm.title
      m.title_index = lm.title_eng
      m.director = lm.director
      m.year = lm.year.to_i
      m.current_rating = lm.rating
      if lm.year_elig != nil
        m.skandies_year = lm.year_elig.to_i
      end
      m.short = lm.short_boolean
      m.save
      lm.legacy_viewings.each do |lv|
        v = Viewing.new
        v.movie_id = m.id
        v.date = lv.date_seen
        v.rating = m.current_rating
        v.format_id = lv.format
        v.save
      end
    end
  end

end
