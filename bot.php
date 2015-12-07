<?
$result= json_decode(file_get_contents('php://input'), true);
error_log(print_r($result, 1), 3, 'log.log');

$user_id = $result['message']['chat']['id'];
$text = $result['message']['text'];
$user = $result['message']['from']['first_name'];
$userlast = $result['message']['from']['last_name'];

$url2 = "SIMURL";

switch (true)
{
        case $text == '/ping':
        $text_reply = 'pong';
        break;

        case $text == '/cats':
        $text_reply = 'http://procatinator.com/';
        break;

	case $text == '/who';

	$message = "scan";
       
               exec('wget -q --output-document=/dev/null --post-data="'
                                ."{$message}\" --timeout=15 \"$url2\"");
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
	if(isset($text) && $user_id == "-59626787" && $text != "/who")
	{

		if(isset($userlast)){$user = "$user $userlast";}
			$message = "$user: $text";
	
		 	exec('wget -q --output-document=/dev/null --post-data="' 
				."{$message}\" --timeout=15 \"$url2\"");
	}
?>
