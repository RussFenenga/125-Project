---

#Web API

###Get all events
 - type: `POST or GET`
 - url: `eventhype.me/api/events`
 - returns: `(array)` of event objects
 
###Get specific event
 - type: `POST or GET`
 - url: `eventhype.me/api/event` + `?column=`COLUMN_NAME + `&query=`QUERY
 - returns: `(array)` with event object(s)