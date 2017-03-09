**MyEvents:**

ARTUR GRIGIO ( [grigory1@uci.edu)](mailto:grigory1@uci.edu))

THOMAS HALSTEAD ( [halsteat@uci.edu](mailto:halsteat@uci.edu))

RUSSEL FENENGA ( [russfenenga@gmail.com)](mailto:russfenenga@gmail.com))

JONATHAN PETOTE ( [jpetote@uci.edu)](mailto:jpetote@uci.edu))

Git repository ( [https://github.com/ArturGrigio/125-Project](https://github.com/ArturGrigio/125-Project))

**Problem:**

1. This project will help people to find events around them from a mobile platform or a desktop. Additionally, users will be able to input their own events using these value:
  1. Location
  2. Event Title
  3. Event Description
  4. Event Image
  5. Tags describing event type
2. The project will have a generated (simulated) data stream of events. The live data feed will be provided by the user (in form of the user&#39;s location longitude and latitude), and user&#39;s view will update based on his location.

**Approach:**

1. Spin up a AWS EC2 instance that will run the API framework.
2. Connect the framework to a SQL database that will have the data stream of all the available events.
3. Write an API specific to the application
4. Write a frontend that will act as the Desktop entry for the user
5. Write a Mobile (iOS) app that will provide the functionality to view events and add events using the API.
6. Connect the mobile application to the API to utilize the same datasource as the Desktop app.

**Data Sources:**

1. Simulated Data of Events
2. User location data  used for catering the view to the user location



**Roles and Responsibilities for Team Members:**

1. Artur Grigoryan – AWS setup (as he is AWS certified), Write the API in Laravel, Seed the data in the database.
2. Russel Fenenga – Create the iOS app, connect the app to API, provide the environment for the AWS and Domain name.
3. Thomas Halstead – Write the frontend of the Desktop app as he would like to learn more about web development.
4. Jonathan Petote – Write the frontend for the iOS app.

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
