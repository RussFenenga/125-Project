<!DOCTYPE html>
<html>
  <head>
    <style>
       #map {
        height: 100vh;
        width: 100%;
       }
    </style>
  </head>
  <body>
    <div id="map"></div>
    <script>
      var userloc = {lat: 33.6487, lng: -117.8425};
      var map;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: userloc,
          zoom: 12
        });
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(
            function(position) { 
              userloc = { lat: position.coords.latitude, lng: position.coords.longitude };
              map.setCenter(userloc);
              populateEvents();
            }, 
            function() {
              handleLocationError(true);
            }
          );
        } 
        else {
          // Browser doesn't support Geolocation
          handleLocationError(false);
        }
      }
      function handleLocationError(browserHasGeolocation) {
      }
<?php
      function eventInWindow($event_json, $cutoff) {
        $duration = getDuration($event_json);        
        $now = strtotime(date('Y-m-d h:i:sa'));
        return ($duration["start"] <= $now + $cutoff) &&
               ($now < $duration["end"]);
      }
      function normalize($value) {
        $value = htmlentities($value);
        $value = nl2br($value);
        $value = str_replace(array("\r","\n"), '', $value);
        return $value;
      }
      function normalizeFields($event_json) {
        foreach($event_json as $key => &$value) {
          $value = normalize($value);
        }
        return $event_json;
      }
      function getDuration($event_json) {
        return array( "start" => strtotime($event_json->start_date . " " . $event_json->start_time),
                      "end" => strtotime($event_json->end_date . " " . $event_json->end_time));
      }
      function formatDuration($event_json) {
        $duration = getDuration($event_json);
        $day_format = "l F d";
        $time_format = " g:ia";
        $ret = "";
        if($event_json->start_date != $event_json->end_date) {
          $ret = $ret . date($day_format . $time_format, $duration["start"]);
          $ret = $ret . " - " . date($day_format . $time_format, $duration["end"]);
        }
        else {
          $ret = $ret . date($day_format . $time_format, $duration["start"]);
          $ret = $ret . " - " . date($time_format, $duration["end"]);
        }
        return $ret;
      }
      function generateContent($event_json) {
        $event_json = normalizeFields($event_json);
        $ret = "";
        $ret = $ret . "<h2><a href=" . $event_json->url . ">" . $event_json->event_name . "</a></h2>";
        $ret = $ret . "<h3>" . $event_json->event_address . "</h3><br>";
        $ret = $ret . "<p>" . normalize($event_json->event_description) . "</p>";
        $ret = $ret . formatDuration($event_json);
        return $ret;
      }
?>
      function populateEvents() {
        @foreach($events as $event)
          @if (eventInWindow($event, 24*3*3600))
            var info_{{$event->id}} = new google.maps.InfoWindow({content: "{!!generateContent($event)!!}"});
            var marker_{{$event->id}} = new google.maps.Marker({
              position: {lat: {{$event->latitude}}, lng: {{$event->longitude}} },
              map: map,
              title: "{{$event->event_name}}"
            });
            marker_{{$event->id}}.addListener('click', function() { info_{{$event->id}}.open(map, marker_{{$event->id}}); });
          @endif
        @endforeach
      }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDAeplbwF_97JDwOEZ6_t6F-u0yL17q6lw&callback=initMap">
    </script>
  </body>
</html>
