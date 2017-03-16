<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;

class APIController extends Controller
{
    public function getAll() {
    	return json_encode(Event::orderBy('created_at', 'DESC')->get());
    }

    public function getEvent(Request $request) {
    	if(!$request->has('column') || !$request->has('query')) {
		    return [];
	    } else {
		    $column = $request->get('column');
		    $query = $request->get('query');
		    if($request->has('operator'))
			    return json_encode(Event::where($column, $request->get('operator'),$query)->get());
	        else
		        return json_encode(Event::where($column, $query)->get());
	    }
    }

    public function insert(Request $request) {
    	Event::create(array(
    		'event_name'=>$request->has('event_name') ? $request->get('event_name') : '',
		    'event_description'=> $request->has('event_description') ? $request->get('event_description') : '',
		    'event_address'=> $request->has('event_address') ? $request->get('event_address') : '',
		    'latitude'=> $request->has('latitude') ? $request->get('latitude') : '',
		    'longitude'=> $request->has('longitude') ? $request->get('longitude') : '',
		    'category'=> $request->has('category') ? $request->get('category') : '',
		    'url'=> $request->has('url') ? $request->get('url') : '',
		    'source'=> $request->has('source') ? $request->get('source') : '',
		    'price'=> $request->has('price') ? $request->get('price') : '',
		    'logo'=> $request->has('logo') ? $request->get('logo') : '',
		    'start_date'=> $request->has('start_date') ? $request->get('start_date') : '',
		    'start_time'=> $request->has('start_time') ? $request->get('start_time') : '',
		    'end_date'=> $request->has('end_date') ? $request->get('end_date') : '',
		    'end_time'=> $request->has('end_time') ? $request->get('end_time') : ''
	    ));
    }
}
