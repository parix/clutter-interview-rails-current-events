# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create event dates from 2000/1/1 to today.
(Date.parse("2000/1/1")..Date.today).each do |date|
  EventDate.create(:date => date)
end

# Populate events for the month of January 2017
events = WikiScraper::Events.get_events(month: "January_2017")
events.each { |date, events| events.each { |e| Event.create(event_date: EventDate.find_by(date: date), title: e['title'], summary: e['summary'], image_url: e['image_url']) } }; nil
