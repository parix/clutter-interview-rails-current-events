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
