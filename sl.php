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
else if(!$me)
{
	$text_reply = "$who: $message";
}
else
{
	$text_reply = "$who"."$message";
}

if(isset($message))
{	
	$token "";
	$url = 'https://api.telegram.org/.$token./sendMessage?chat_id='.$user_id;
	$url .= '&text=' .$text_reply;
	$res = file_get_contents($url);
}
?>
