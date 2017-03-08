<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Http\Request;

class APIController extends Controller
{
    public function getAll() {
    	return json_encode(Event::all());
    }

    public function getEvent(Request $request) {
    	if(!$request->has('column') || !$request->has('query')) {
		    return [];
	    } else {
		    $column = $request->get('column');
		    $query = $request->get('query');
		    return json_encode(Event::where($column, $query)->get());
	    }
    }
}
