<?php

use Illuminate\Database\Seeder;

class EventSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$tags = ['club', 'restaurant', 'school'];
	    $faker = Faker\Factory::create();

	    for($i = 0; $i<50; $i++) {
		    $event = \App\Event::create(array(
			    'event_name' => $faker->word(),
			    'event_description' => $faker->sentence(),
			    'event_address' => $faker->address(),
			    'latitude' => $faker->latitude($min = 33.54, $max = 33.74),
			    'longitude' => $faker->longitude($min = -117.74, $max = -117.94),
			    'category' => $tags[rand(0,2)],
			    'subcategory' => $faker->word(),
			    'price' => (rand(0, 5)) ? rand(10, 35) : "FREE",
			    'start_date'=> $faker->date(),
			    'start_time'=> $faker->time(),
			    'end_date'=> $faker->date(),
			    'end_time'=> $faker->time()
		    ));
	    }
    }
}
