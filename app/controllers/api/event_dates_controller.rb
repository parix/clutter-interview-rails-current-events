module Api
  class EventDatesController < ApplicationController
    def index
      respond_to do |format|
        format.json { render json: EventDate.all.map(&:to_json) }
      end
    end

    def show
      respond_to do |format|
        format.json { render json: EventDate.find_by(:date => Date.parse(params[:date])).events.map(&:to_json) }
        #format.json { render json: EventDate.find_by(:date => Date.parse(params[:date])).events.map(&:title) }
      end
    end
  end
end
