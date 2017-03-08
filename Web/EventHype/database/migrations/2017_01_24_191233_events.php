<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Events extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
	    Schema::create('events', function (Blueprint $table) {
		    $table->increments('id');
		    $table->string('event_name')->nullable();
		    $table->string('event_description')->nullable();
		    $table->string('event_address')->nullable();
		    $table->string('latitude')->nullable();
		    $table->string('longitude')->nullable();
		    $table->string('category')->nullable();
		    $table->string('subcategory')->nullable();
		    $table->string('price')->nullable();
		    $table->date('start_date')->nullable();
		    $table->time('start_time')->nullable();
		    $table->date('end_date')->nullable();
		    $table->time('end_time')->nullable();
		    $table->timestamps();
	    });
    }

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('events');
	}
}
