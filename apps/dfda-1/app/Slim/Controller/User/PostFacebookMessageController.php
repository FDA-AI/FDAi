<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnused */
namespace App\Slim\Controller\User;
use App\Slim\Controller\PostController;
class PostFacebookMessageController extends PostController {
	public function post(){
		$access_token =
			"EAADMtR3LoiUBAO4hZBsrzuZApVigUUhKwwOPYA8OM2yRAHfNbdsOmS5I0Kob5GzS2rdFhe7Wq9ZAZCZAOA8qK7KutIy9AjyXctR6r6000pBeml5FtHtvadpNkZBZCfNZBHpnXJZA6klPJDNutKrAylXSPj1hURpNZAAdwIXhwp8P64EAZDZD";
		$verify_token = "lalala123123";
		$hub_verify_token = null;
		if(isset($_REQUEST['hub_challenge'])){
			$challenge = $_REQUEST['hub_challenge'];
			$hub_verify_token = $_REQUEST['hub_verify_token'];
		}
		if($hub_verify_token === $verify_token){
			echo $challenge;
		}
		$input = json_decode(file_get_contents('php://input'), true);
		$sender = $input['entry'][0]['messaging'][0]['sender']['id'];
		$message = $input['entry'][0]['messaging'][0]['message']['text'];
		$message_to_reply = '';
		/**
		 * Some Basic rules to validate incoming messages
		 */
		if(preg_match('[time|current time|now]', strtolower($message))){
			// Make request to Time API
			ini_set('user_agent', 'Mozilla/4.0 (compatible; MSIE 6.0)');
			$result =
				file_get_contents("http://www.timeapi.org/utc/now?format=%25a%20%25b%20%25d%20%25I:%25M:%25S%20%25Y");
			if($result != ''){
				$message_to_reply = $result;
			}
		} else{
			$message_to_reply = 'What is your mood on a scale of l to 5?';
		}
		//API Url
		$url = 'https://graph.facebook.com/v2.6/me/messages?access_token=' . $access_token;
		//Initiate cURL.
		$ch = curl_init($url);
		QMLog::error('sender is ' . $sender);
		//The JSON data.
		$jsonData = '{
            "recipient":{
                "id":"' . $sender . '"
            },
            "message":{
                "text":"' . $message_to_reply . '"
            }
        }';
		$jsonData2 = '{
                      "recipient":{
                        "id":"' . $sender . '"
                      },
                      "message":{
                        "attachment":{
                          "type":"template",
                          "payload":{
                            "template_type":"generic",
                            "elements":[
                               {
                                "title":"Welcome to Peters Hats",
                                "image_url":"https://petersfancybrownhats.com/company_image.png",
                                "subtitle":"We have ve got the right hat for everyone.",
                                "default_action": {
                                  "type": "web_url",
                                  "url": "https://peterssendreceiveapp.ngrok.io/view?item=103",
                                  "messenger_extensions": true,
                                  "webview_height_ratio": "tall",
                                  "fallback_url": "https://peterssendreceiveapp.ngrok.io/"
                                },
                                "buttons":[
                                  {
                                    "type":"web_url",
                                    "url":"https://petersfancybrownhats.com",
                                    "title":"View Website"
                                  },{
                                    "type":"postback",
                                    "title":"Start Chatting",
                                    "payload":"DEVELOPER_DEFINED_PAYLOAD"
                                  }
                                ]
                              }
                            ]
                          }
                        }
                      }
                    }';
		$ob = json_decode($jsonData);
		if($ob === null){
			// $ob is null because the json cannot be decoded
		}
		//Encode the array into JSON.
		$jsonDataEncoded = $jsonData;
		//Tell cURL that we want to send a POST request.
		curl_setopt($ch, CURLOPT_POST, 1);
		//Attach our encoded JSON string to the POST fields.
		curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);
		//Set the content type to application/json
		curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
		//curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));
		//Execute the request
		if(!empty($input['entry'][0]['messaging'][0]['message'])){
			$result = curl_exec($ch);
		}
		//curl -X POST "https://graph.facebook.com/v2.6/me/subscribed_apps?access_token=EAADMtR3LoiUBAO4hZBsrzuZApVigUUhKwwOPYA8OM2yRAHfNbdsOmS5I0Kob5GzS2rdFhe7Wq9ZAZCZAOA8qK7KutIy9AjyXctR6r6000pBeml5FtHtvadpNkZBZCfNZBHpnXJZA6klPJDNutKrAylXSPj1hURpNZAAdwIXhwp8P64EAZDZD"
	}
}
