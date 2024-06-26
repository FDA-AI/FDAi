<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\StagingUnitTests\A\AppSettings;
use App\Models\OAAccessToken;
use App\Properties\OAAccessToken\OAAccessTokenAccessTokenProperty;
use Tests\SlimStagingTestCase;
class AppSettingsForPreveTest extends SlimStagingTestCase
{
    public $maximumResponseArrayLength = false;
    public $minimumResponseArrayLength = false;
	public function setUp(): void{
		parent::setUp(); // TODO: Change the autogenerated stub
	}
	public function testAppSettingsForPreve(){
        $result =
            OAAccessToken::whereAccessToken("350491843848a2cb9a2767e3af78326bbd0c22f5")
                ->update([OAAccessToken::FIELD_EXPIRES => db_date(time() + 86400)], "testing");
        $expectedString = '';
        $responseBody = $this->callAndCheckResponse($expectedString);
        $this->checkTestDuration(17);
        $this->checkQueryCount(9);
    }
    public $expectedResponseSizes = [
        //'allAppSettings' => 86.0,
        'allAppSettings' => 183,
        // We return physician apps now
    ];
    public $slimEnvironmentSettings = [
        'REQUEST_METHOD'          => 'GET',
        'REMOTE_ADDR'             => '10.0.2.2',
        'SCRIPT_NAME'             => '',
        'PATH_INFO'               => '/api/v1/appSettings',
        'SERVER_NAME'             => '_',
        'SERVER_PORT'             => '443',
        'HTTP_X_FIRELOGGER'       => '1.3',
        'HTTP_COOKIE'             => '_ga=GA1.2.1529173137.1542067642; _gid=GA1.2.1572338738.1542067642; final_callback_url=https%3A%2F%2Flocal.quantimo.do%2Fionic%2FModo%2Fsrc%2Fconfiguration-index.html',
        'HTTP_ACCEPT_LANGUAGE'    => 'en-US,en;q=0.9',
        'HTTP_ACCEPT_ENCODING'    => 'gzip, deflate, br',
        'HTTP_REFERER'            => 'https://local.quantimo.do/ionic/Modo/src/configuration-index.html',
        'HTTP_USER_AGENT'         => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36',
        'HTTP_AUTHORIZATION'      => 'Bearer '.OAAccessTokenAccessTokenProperty::TEST_ACCESS_TOKEN_FOR_ANY_REFERRER_DOMAIN,
        'HTTP_ACCEPT'             => 'application/json, text/plain, */*',
        'HTTP_CONNECTION'         => 'keep-alive',
        'CONTENT_LENGTH'          => '',
        'CONTENT_TYPE'            => '',
        'slim.url_scheme'         => 'https',
        'slim.input'              => '',
        'slim.request.query_hash' => [
            'all'         => 'true',
            'designMode'  => 'true',
            'appName'     => 'QuantiModo',
            'accessToken' => '350491843848a2cb9a2767e3af78326bbd0c22f5',
            'clientId'    => 'quantimodo',
            'platform'    => 'web',
        ],
        'responseStatusCode'      => 200,
        'unixtime'                => 1542067725,
        'requestDuration'         => 5.034627199172974,
    ];
}
