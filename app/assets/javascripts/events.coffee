# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

display_events = (date) ->
  $.ajax
    url: "api/event_dates/#{date}"
    dataType: "json"
    success: (event_date, textStatus, jqXHR) ->
      $('#events').empty()
      if event_date['status'] == "Updating"
        $('#events').append("<h3>We are currently updating this page as it may be out of date.</h3>")
      $('#events').append("<h1>#{date}</h1>")
      $('#events').append("<p>Last Update: #{event_date['last_update_at']}</p>")
      display_event = (event) ->
        $('#events').append("<h2>#{event['title']}</h2>")
        if event['image_url'] != null
          $('#events').append("<img src=\"#{event['image_url']}\">")
        $('#events').append(event['summary'])
        $('#events').append("<hr>")
      display_event event for event in event_date['events']

format_date = (date) ->
  month = '' + (date.getMonth() + 1)
  day = '' + date.getDate()
  year = date.getFullYear()

  if (month.length < 2) then month = '0' + month
  if (day.length < 2) then day = '0' + day

  return [year, month, day].join('-')

ready = () ->
  $('#datepicker').datepicker({
    "startDate": "2000-01-01",
    "format": "yyyy-mm-dd"
  }).on 'changeDate', (e) ->
    display_events(format_date($('#datepicker').datepicker('getDate')))

  if isNaN(Date.parse(window.location.pathname))
    $("#datepicker").datepicker("setDate", new Date())
  else
    $("#datepicker").datepicker("setDate", new Date(Date.parse(window.location.pathname)))

  setInterval () ->
    display_events(format_date($('#datepicker').datepicker('getDate')))
  , 120000

  display_events(format_date($('#datepicker').datepicker('getDate')))

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
