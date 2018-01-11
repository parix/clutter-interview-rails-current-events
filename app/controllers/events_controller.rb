class EventsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: { "events" => "1" } }
    end
  end
end
