<?

$message = $_GET['message'];
$who = $_GET['name'];

$user_id = "-59626787"; // this is the telegram group chat ID you can get this from the logs

if (strpos($message,'/me') !== false)
{
    $me = true;
}

$message = str_replace("/me", "", $message);

if($who == "")
{
	$text_reply = "$message";
}
if($who == "Avatars")
{
	$text_reply = "Avatar Scan\n==========\n".$message."--------\nAre in range of the relay (20m)";
}
else if(!$me)
{
	$text_reply = "$who: $message";
}
else
{
	$text_reply = "$who"."$message";
}

$text_reply = urlencode($text_reply);

if(isset($message))
{
	$token = ""; // THE botfather gives you this token
	$url = 'https://api.telegram.org/.$token./sendMessage?chat_id='.$user_id;
	$url .= '&text=' .$text_reply;
	$res = file_get_contents($url);
}
?>
