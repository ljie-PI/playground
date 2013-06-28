<?php

require("env.php");

if(!isset ($_REQUEST['code'])){
	echo "Can't get the code!";
	exit;
}
$request_code = $_REQUEST['code'];

$get_token_url = GET_TOKEN_URL;
$post_data = array(
	"client_id"	=> APP_KEY,
	"client_secret"=> SECRET_KEY,
	"redirect_uri"	=> REGISTERED_REDIRECT_URI,
	"code" 		=> $request_code,
	"grant_type"	=> "authorization_code",
);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $get_token_url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$ret_json = curl_exec($ch);
$ret_arr = json_decode($ret_json, true);
echo $ret_arr['access_token'];
