module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Fireman Save My Child"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_year
    Time.new.year
  end

  def last_year
    current_year - 1
  end

  def letter_grade(rating)
    case rating
    when 91..100
      'A'
    when 82..90
      'A-'
    when 73..81
      'B+'
    when 64..72
      'B'
    when 55..63
      'B-'
    when 46..54
      'C+'
    when 37..45
      'C'
    when 28..36
      'C-'
    when 19..27
      'D+'
    when 10..18
      'D'
    when 1..9
      'D-'
    when 0
      'F'
    end
  end

  def star_rating(rating)
    case rating
    when 91..100
      5
    when 81..90
      4.5
    when 71..80
      4
    when 61..70
      3.5
    when 51..60
      3
    when 41..50
      2.5
    when 31..40
      2
    when 21..30
      1.5
    when 11..20
      1
    when 1..10
      0.5
    when 0
      0
    end
  end
end
