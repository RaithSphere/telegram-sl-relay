<?
$result= json_decode(file_get_contents('php://input'), true);
error_log(print_r($result, 1), 3, 'log.log');

$user_id = $result['message']['chat']['id'];
$text = $result['message']['text'];
$user = $result['message']['from']['first_name'];
$userlast = $result['message']['from']['last_name'];


switch (true)
{
        case $text == '/ping':
        $text_reply = 'pong';
        break;

}

if(isset($text_reply))
{
	$token = '';
	$url = 'https://api.telegram.org/.$token./sendMessage?chat_id='.$user_id;
	$url .= '&text=' .$text_reply;
	$res = file_get_contents($url); 
	$message = "$username: $text";
}
	if(isset($text))
	{

		if(isset($userlast)){$user = "$user $userlast";}
			$message = "$user: $text";
			$url2 = "CAPURLHERE";
		 	exec('wget -q --output-document=/dev/null --post-data="' 
				."{$message}\" --timeout=15 \"$url2\"");
	}
?>
