<?php

function generateInfoContent($event_json) {
    $ret = "";
    $ret = $ret . "<h3><a href=" . normalize($event_json->url) . ">" . normalize($event_json->event_name) . "</a></h3>";
    $ret = $ret . "<h4>" . formatDuration($event_json) . "</h4>";
    $ret = $ret . "<h4>" . normalize($event_json->event_address) . "</h4><br>";
    $ret = $ret . "<img src=" . normalize($event_json->logo) . "/>";
    $ret = $ret . "<p>" . normalize($event_json->event_description) . "</p>";
    return $ret;
}

?>
<script>
    {!! $location !!}
    var map;
    var openWindow = null;
    function geoLocate(fallback) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    fallback = {lat: position.coords.latitude, lng: position.coords.longitude};
                    map.setCenter(userloc);
                    populateEvents();
                },
                function () {
                    handleLocationError(true);
                }
            );
        }
        else {
            // Browser doesn't support Geolocation
            handleLocationError(false);
        }
    }

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: userloc,
            zoom: 12
        });
    }

    function handleLocationError(browserHasGeolocation) {
        alert(browserHasGeolocation);
    }

    function populateEvents() {
        @foreach($events as $event)
            var info_{{$event->id}} = new google.maps.InfoWindow();
            var marker_{{$event->id}} = new google.maps.Marker({
                position: {lat:{{$event->latitude}}, lng:{{$event->longitude}} },
                map: map,
                title: "{{$event->event_name}}"
            });
            marker_{{$event->id}}.addListener('click', function () {
                if(openWindow)
                    openWindow.close();
                openWindow = new google.maps.InfoWindow({content: "{!!generateInfoContent($event)!!}"});
                openWindow.open(map, marker_{{$event->id}});
            });
        @endforeach
    }
</script>

<div id="map" style="height:100vh; width:100vw;"></div>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDAeplbwF_97JDwOEZ6_t6F-u0yL17q6lw&callback=initMap">
</script>
