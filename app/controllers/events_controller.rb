class EventsController < ApplicationController
  def index
    @event_dates = EventDate.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @event_date = EventDate.find_by(date: Date.parse(params[:date]))

    respond_to do |format|
      format.html
    end
  end
end
