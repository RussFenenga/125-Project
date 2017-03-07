<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Stripe, Mailgun, SparkPost and others. This file provides a sane
    | default location for this type of information, allowing packages
    | to have a conventional place to find your various credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
    ],

    'ses' => [
        'key' => env('SES_KEY'),
        'secret' => env('SES_SECRET'),
        'region' => 'us-east-1',
    ],

    'sparkpost' => [
        'secret' => env('SPARKPOST_SECRET'),
    ],

    'stripe' => [
        'model' => App\User::class,
        'key' => env('STRIPE_KEY'),
        'secret' => env('STRIPE_SECRET'),
    ],

	'firebase' => [
		'api_key' => 'AIzaSyCtb-YN1iUCUn_Cd36iWtf1k4rZxVJh3Pg', // Only used for JS integration
		'auth_domain' => 'eventhype-4186a.firebaseapp.com', // Only used for JS integration
		'database_url' => 'https://eventhype-4186a.firebaseio.com',
		'secret' => 'eventhype-4186a.appspot.com',
		'storage_bucket' => '856210841296', // Only used for JS integration
	],

];
