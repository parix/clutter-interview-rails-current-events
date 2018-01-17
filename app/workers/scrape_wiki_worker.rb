class ScrapeWikiWorker
  include Sidekiq::Worker

  def perform(month)
		event_month = EventMonth.find_or_create_by(month: month)
    latest_checksum = event_month.latest_checksum
    events = WikiScraper::Events.get_events(month: month || Date.today.strftime("%B_%Y"))
    events.each do |date, events|
			event_date = EventDate.find_or_create_by(event_month: event_month, date: date)
      event_date.events.destroy_all
      events.each do |e|
        Event.create(
          event_date: event_date,
          title: e['title'],
          summary: e['summary'],
          image_url: e['image_url']
        )
      end
    end
    event_month.update_attributes(status: 'Updated', checksum: latest_checksum)
  end
end
