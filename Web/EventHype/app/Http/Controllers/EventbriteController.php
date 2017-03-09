<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
use Carbon\Carbon;

class EventbriteController extends Controller
{
    public static function updateIndex() {
    	$page = 1;

	    $price = [9.95, 14.99, 25, 28.95];
	    $categories = [];
	    $catClient = new Client([
		    // Base URI is used with relative requests
		    'base_uri' => 'https://www.eventbriteapi.com/v3/categories'
	    ]);
	    $response = $catClient->request('GET',
		    '?token=DEHPGRHYQQSLQDVHP3Y3'
	    );
	    $data = json_decode($response->getBody());
	    foreach($data->categories as $category) {
			$categories[$category->id] = $category->name;
	    }

	    while($page) {
		    $client = new Client([
			    // Base URI is used with relative requests
			    'base_uri' => 'https://www.eventbriteapi.com/v3/events/search'
		    ]);
		    $response = $client->request('GET',
			    '?token=DEHPGRHYQQSLQDVHP3Y3&page='.$page.
			    '&location.viewport.northeast.latitude=33.670568'.
			    '&location.viewport.northeast.longitude=-117.800069'.
		        '&location.viewport.southwest.latitude=33.602757'.
		        '&location.viewport.southwest.longitude=-117.908731'.
		        '&token=DEHPGRHYQQSLQDVHP3Y3'
		    );
		    $data = json_decode($response->getBody());

		    foreach($data->events as $event) {
		    	print_r($event);
		    	if(Event::where('id', $event->id)->get()->isEmpty()) {
				    $start = Carbon::parse($event->start->local);
				    $end = Carbon::parse($event->end->local);
				    $event = Event::create(array(
					    'id' => $event->id,
					    'event_name' => $event->name->text,
					    'event_description' => substr($event->description->text,0, 4996),
					    'event_address' => "View Description",
					    'latitude' => $data->location->latitude,
					    'longitude' => $data->location->longitude,
					    'logo' => ($event->logo) ? $event->logo->url : "http://EventHype.me/img/eventimage.png",
					    'category' => ($event->category_id) ? $categories[$event->category_id] : 'Other',
					    'url' => $event->url,
					    'source' => "EventBrite",
					    'price' => $event->is_free ? "FREE" : $price[rand(0, 3)],
					    'start_date' => $start->toDateString(),
					    'start_time' => $start->toTimeString(),
					    'end_date' => $end->toDateString(),
					    'end_time' => $end->toTimeString()
				    ));
			    }
		    }
		    if($data->pagination->page_count == $page) {
		    	$page = null;
		    } else {
		    	$page = $data->pagination->page_number + 1;
		    }
		}
    }
}
