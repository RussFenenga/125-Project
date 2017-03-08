<?php

namespace App\Http\Controllers;

use App\Event;
use Illuminate\Http\Request;

class APIController extends Controller
{
    public function getAll() {
    	return json_encode(Event::all());
    }
}
