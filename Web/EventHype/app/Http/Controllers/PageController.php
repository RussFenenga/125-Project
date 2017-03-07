<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Http\Request;

class PageController extends Controller
{
    public function showMain(Request $request) {
    	$event = Event::create()


    	return view('welcome');
    }
}
