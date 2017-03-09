---

#Web API

###Get all events
 - type: `POST or GET`
 - url: `eventhype.me/api/events`
 - returns: `(array)` of event objects
 
###Get specific event
 - type: `POST or GET`
 - request parameters:
   - column: `string` one of these columns: 
     - `id`,`event_name`
     - `event_address`
     - `event_description` 
     - `latitude`
     - `longitude`
     - `category`
     - `price`
     - `url`
     - `logo`
     - `start_date`
     - `start_time`
     - `end_date`
     - `end_time`
   - operator **OPTIONAL**: `string` one of these SQL operators:
     - `=`
     - `<`
     - `>`
     - `<=`
     - `like`
     - and other SQL operators
   - query: `string` a string for SQL query
 - url: `eventhype.me/api/event` + `?column=`COLUMN_NAME + `&operator=`OPERATOR + `&query=`QUERY
 - returns: `(array)` with event object(s)