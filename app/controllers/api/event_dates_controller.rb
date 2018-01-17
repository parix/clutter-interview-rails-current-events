module Api
  class EventDatesController < ApplicationController
    def index
      respond_to do |format|
        format.json { render json: EventDate.all.map(&:to_hash) }
      end
    end

    def show
      date = Date.parse(params[:date])
      event_month = EventMonth.find_or_create_by(:month => date.strftime("%B_%Y"))
      event_date = EventDate.find_or_create_by(:event_month => event_month, :date => date)

      if event_date.event_month.queue_job?
        event_month.update_attributes(:status => "Updating")
        ScrapeWikiWorker.perform_async(date.strftime("%B_%Y"))
        event_date.reload
      end

      respond_to do |format|
        format.json { render json: event_date.events_hash }
      end
    end
  end
end
