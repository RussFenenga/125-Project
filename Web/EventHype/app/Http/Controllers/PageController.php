<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Http\Request;

class PageController extends Controller
{
    public function showMain(Request $request) {
        $location = "var userloc = {lat: 33.6487, lng: -117.8425}; geoLocate(userloc);\n";
        if(array_key_exists('lat', $request) && array_key_exists('lng', $request))
            $location = "var userloc = {lat:" . $request['lat'] . ", lng:" . $request['lng'] . "};\n";
    	return view('welcome')->with(['events'=>Event::orderBy('created_at', 'DESC')->get(), 'location'=>$location]);
    }
}
