<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use League\Flysystem\Exception;
use Stevenmaguire\OAuth2\Client\Provider\Eventbrite as Provider;

class EventbriteController extends Controller
{
    public function authenticate() {
	    $provider = new Provider([
		    'clientId'          => 'ULZDKWPFXIAIHRTJG2',
		    'clientSecret'      => 'FSXJPOYCZM3TLEJ73X5DCDJCFE3OIB4NZIYHQNAMHFGW3P3OLG',
		    'redirectUri'       => 'eventhype.me/eventbrite'
	    ]);

	    if (!isset($_GET['code'])) {

		    // If we don't have an authorization code then get one
		    $authUrl = $provider->getAuthorizationUrl();
		    $_SESSION['oauth2state'] = $provider->getState();
		    header('Location: '.$authUrl);
		    exit;

		// Check given state against previously stored one to mitigate CSRF attack
	    } elseif (empty($_GET['state']) || ($_GET['state'] !== $_SESSION['oauth2state'])) {

		    unset($_SESSION['oauth2state']);
		    exit('Invalid state');

	    } else {

		    // Try to get an access token (using the authorization code grant)
		    $token = $provider->getAccessToken('authorization_code', [
			    'code' => $_GET['code']
		    ]);

		    // Optional: Now you have a token you can look up a users profile data
		    try {

			    // We got an access token, let's now get the user's details
			    $user = $provider->getResourceOwner($token);

			    // Use these details to create a new profile
			    printf('Hello %s!', $user->getUserId());

		    } catch (Exception $e) {

			    // Failed to get user details
			    exit('Oh dear...');
		    }

		    // Use this to interact with an API on the users behalf
		    echo $token->getToken();
	    }
    }
}
