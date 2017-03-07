<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Mpociot\Firebase\SyncsWithFirebase;

class Event extends Model
{
	use SyncsWithFirebase;
	protected $guarded = [];

}
