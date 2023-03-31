<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\ConnectorTests\B;
use App\DataSources\Connectors\GoogleLoginConnector;
use Tests\ConnectorTests\ConnectorTestCase;
/**
 * @package Tests\Api\Connectors
 */
class GoogleLoginTest extends ConnectorTestCase {
    protected const DISABLED_UNTIL = "2023-04-01";
	protected const REASON_FOR_SKIPPING = "Refresh token keeps being missing";
    public $connectorName = GoogleLoginConnector::NAME;
    public function testGoogleLogin() {
        $this->checkConnectorLogin();
    }
    public function testGooglePlusIosNativeLogin() {
        if (true) {
            $this->skipTest('Not sure why this is disabled?');
            return;
        }
        $nativeIosLoginResponse = '{
            "userId":"118444693184829555362",
            "displayName":"Mike Sinn",
            "imageUrl":"https://lh6.googleusercontent.com/-BHr4hyUWqZU/AAAAAAAAAAI/AAAAAAAIG28/2Lv0en738II/s120/photo.jpg",
            "refreshToken":"1/4dOinmfjoEss01HDHuObr_3hUyORkZZCTXUqSrcTB7Q",
            "email":"m@thinkbynumbers.org",
            "serverAuthCode":"",
            "accessToken":"ya29.GlzcBcukKbKYF9Xar68zG-9T7zrG8DR33SSK9XfiGVnJL47CLGfgmVH8eK_dkuvEvnSwERbn0dRm_uigunZFict3K_z5b_YKFOEKzEkNOoyC2s5UQoBTiw2F2fW-9g",
            "givenName":"Mike",
            "idToken":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjdkZGY1NGQzMDMyZDFmMGQ0OGMzNjE4ODkyY2E3NGMxYWMzMGFkNzcifQ.eyJhenAiOiIxMDUyNjQ4ODU1MTk0LTljdjZscjdkNjE3ZnU2Yjk1Z3V0a2M3Z3ZkdWJiOGdsLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTA1MjY0ODg1NTE5NC5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExODQ0NDY5MzE4NDgyOTU1NTM2MiIsImhkIjoidGhpbmtieW51bWJlcnMub3JnIiwiZW1haWwiOiJtQHRoaW5rYnludW1iZXJzLm9yZyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiY2RtOTB6NWlHZzgxVDVWeVZ5bEtYdyIsImV4cCI6MTUyOTEzNTgyMywiaXNzIjoiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTI5MTMyMjIzLCJuYW1lIjoiTWlrZSBTaW5uIiwicGljdHVyZSI6Imh0dHBzOi8vbGg2Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tQkhyNGh5VVdxWlUvQUFBQUFBQUFBQUkvQUFBQUFBQUlHMjgvMkx2MGVuNzM4SUkvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6Ik1pa2UiLCJmYW1pbHlfbmFtZSI6IlNpbm4iLCJsb2NhbGUiOiJlbiJ9.sl4DUmQ63u8A3rs0AGdnWgwO2QrFy8hje14aCKKw7FuaffzrV3-uDYXZQ9GimKguhJ6pOps_oLLYlk3ng0CFlx_QOvMfIM3ylLj_LrSYv9jJdkKJqBRYBq_plr9c2VlvSzshldZSPrsrZYkb-V1GinGYK8dR6lQMLNxiI31S9lj1BPUn1YWW3lPBDIsnUM9JTrWHtwkW2o_lhRU1C3mA3ppjKfKihGhgaIUP_hs1bB8syatsAi4O_dkHhiOIVLiQwFHWdgw58q0Qd34hajx_uKVL5iP-LcL_LULZbOlIXoFdghip-StXvZcCHvAGNzdP7LTPbfP8V2yxdDXbjc7maA",
            "familyName":"Sinn"
        }';
        $this->connectAndGetUser($nativeIosLoginResponse);
    }
    public function testGooglePlusAndroidNativeLogin() {
        if (true) {
            $this->skipTest('Not sure why this is disabled?');
            return;
        }
        $nativeIosLoginResponse = '{
            "userId":"118444693184829555362",
            "displayName":"Mike Sinn",
            "imageUrl":"https://lh6.googleusercontent.com/-BHr4hyUWqZU/AAAAAAAAAAI/AAAAAAAIG28/2Lv0en738II/s120/photo.jpg",
            "refreshToken":"1/4dOinmfjoEss01HDHuObr_3hUyORkZZCTXUqSrcTB7Q",
            "email":"m@thinkbynumbers.org",
            "serverAuthCode":"",
            "accessToken":"ya29.GlzcBcukKbKYF9Xar68zG-9T7zrG8DR33SSK9XfiGVnJL47CLGfgmVH8eK_dkuvEvnSwERbn0dRm_uigunZFict3K_z5b_YKFOEKzEkNOoyC2s5UQoBTiw2F2fW-9g",
            "givenName":"Mike",
            "idToken":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjdkZGY1NGQzMDMyZDFmMGQ0OGMzNjE4ODkyY2E3NGMxYWMzMGFkNzcifQ.eyJhenAiOiIxMDUyNjQ4ODU1MTk0LTljdjZscjdkNjE3ZnU2Yjk1Z3V0a2M3Z3ZkdWJiOGdsLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTA1MjY0ODg1NTE5NC5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExODQ0NDY5MzE4NDgyOTU1NTM2MiIsImhkIjoidGhpbmtieW51bWJlcnMub3JnIiwiZW1haWwiOiJtQHRoaW5rYnludW1iZXJzLm9yZyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiY2RtOTB6NWlHZzgxVDVWeVZ5bEtYdyIsImV4cCI6MTUyOTEzNTgyMywiaXNzIjoiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNTI5MTMyMjIzLCJuYW1lIjoiTWlrZSBTaW5uIiwicGljdHVyZSI6Imh0dHBzOi8vbGg2Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tQkhyNGh5VVdxWlUvQUFBQUFBQUFBQUkvQUFBQUFBQUlHMjgvMkx2MGVuNzM4SUkvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6Ik1pa2UiLCJmYW1pbHlfbmFtZSI6IlNpbm4iLCJsb2NhbGUiOiJlbiJ9.sl4DUmQ63u8A3rs0AGdnWgwO2QrFy8hje14aCKKw7FuaffzrV3-uDYXZQ9GimKguhJ6pOps_oLLYlk3ng0CFlx_QOvMfIM3ylLj_LrSYv9jJdkKJqBRYBq_plr9c2VlvSzshldZSPrsrZYkb-V1GinGYK8dR6lQMLNxiI31S9lj1BPUn1YWW3lPBDIsnUM9JTrWHtwkW2o_lhRU1C3mA3ppjKfKihGhgaIUP_hs1bB8syatsAi4O_dkHhiOIVLiQwFHWdgw58q0Qd34hajx_uKVL5iP-LcL_LULZbOlIXoFdghip-StXvZcCHvAGNzdP7LTPbfP8V2yxdDXbjc7maA",
            "familyName":"Sinn"
        }';
        $this->connectAndGetUser($nativeIosLoginResponse);
    }
}
