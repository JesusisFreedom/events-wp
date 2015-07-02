$ = jQuery
Ajax = require 'ajax-promise'
clndr = require('./clndr')($)
moment = require 'moment'
Handlebars = require 'hbsfy/runtime'

Handlebars.registerHelper 'formatDate', (date, format) ->
  return date.format(format)

calendarTemplate = require './calendar.hbs'
modalTemplate =  require './modal.hbs'

eventViews = []
class eventView
  constructor: (@event, @element) ->
    @element.on 'click' , =>
      modal = modalTemplate @event
      $(document.body).append modal
      modalEl = $("#event-modal-#{@event.id}");
      modalEl
        .modal('show')
        .on 'hidden.bs.modal', ->
          $(this).remove()



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
    eventViews = undefined
    eventViews = []
    data.eventsThisMonth.map (obj) ->
      obj.moment = moment(obj.date, "YYYY-MM-DD hh:mm A")
    data.eventsThisMonth.sort (a,b) ->
      return -1 if a.moment.isBefore(b.moment)
      return 1 if b.moment.isBefore(a.moment)
      return 0
    calendarTemplate data
  doneRendering: ->
    @eventsThisMonth.map (obj) =>
      eventEl = @element.find "[data-event=#{obj.id}]"
      eventViews.push new eventView obj, eventEl
}


getEvents = (moment) ->
  Ajax.get "/wp-json/events/#{moment.month()}/#{moment.year()}"
  .then (response) ->
    calendarControler.setEvents(response.events)

getEvents moment()