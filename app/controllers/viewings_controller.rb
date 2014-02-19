class ViewingsController < ApplicationController
  def index
    if params[:year]
      @year = params[:year]
    else
      @year = Time.now.year.to_s
    end
    start_date = (@year + "-01-01").to_date
    end_date = (@year + "-12-31").to_date
    @viewings = Viewing.where(date: start_date..end_date)
  end
end
