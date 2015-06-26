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
      obj.moment = moment("#{obj.start_date} #{obj.time}", "YYYY-MM-DD hh:mm")
      obj.moment = moment(obj.start_date, "YYYY-MM-DD") if not obj.moment.isValid()
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