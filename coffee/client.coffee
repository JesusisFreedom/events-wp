$ = jQuery
Ajax = require 'ajax-promise'
clndr = require('./clndr')($)
moment = require 'moment'
calendarTemplate = require './calendar.hbs'

calendarControler = $('#ev-wp-clndr')
.clndr {
  daysOfTheWeek: [
    "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
  ],
  dateParameter: 'start_date',

  forceSixRows: true,
  clickEvents:{
    onMonthChange: (moment) ->
      getEvents moment
  },
  render: (data) ->
    calendarTemplate data
}

getEvents = (moment) ->
  Ajax.get "/wp-json/events/#{moment.month()}/#{moment.year()}"
  .then (response) ->
    calendarControler.setEvents(response.events)

getEvents moment()