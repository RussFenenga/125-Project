<?php

$request_fields = ["start_min", "start_max", "end_min", "end_max",
    "lat", "long", "name", "description", "tag"];
$today_request = json_encode(array('start_min'=>0, 'start_max'=>date('Y-m-d'), 'end_min'=>0, 'end_max'=>0));
$result = "";

function getRequest() {
    if(Input::has('name')) {
        return Input::get('name');
    }
    else {
        return "No name";
    }
}

function normalize($value) {
    $value = htmlentities($value);
    $value = nl2br($value);
    $value = str_replace(array("\r","\n"), '', $value);
    return $value;
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
        $ret = $ret . date($day_format . ", " . $time_format, $duration["start"]);
        $ret = $ret . " - " . date($day_format . ", " . $time_format, $duration["end"]);
    }
    else {
        $ret = $ret . date($day_format . ", " . $time_format, $duration["start"]);
        $ret = $ret . " - " . date($time_format, $duration["end"]);
    }
    return $ret;
}

?>


<!DOCTYPE html>
<html>
  <head>
      <title>Event Hype</title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  </head>
  <body>

  @include('map')
  </body>
</html>
