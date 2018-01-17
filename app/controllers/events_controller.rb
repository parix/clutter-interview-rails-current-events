class EventsController < ApplicationController
  def index
    @event_dates = EventDate.all.order(date: :desc)

    respond_to do |format|
      format.html
    end
  end

  def show
    @event_date = EventDate.find_or_create_by(date: Date.parse(params[:date] || Date.today.strftime("%Y-%m-%d")))

    respond_to do |format|
      format.html
    end
  end
end
