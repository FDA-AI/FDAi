<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace Netatmo\Exceptions;
class NAApiErrorType extends NAClientException {
    public $http_code;
    public $http_message;
    public $result;
    /**
     * NAApiErrorType constructor.
     * @param $code
     * @param $message
     * @param $result
     */
    public function __construct($code, $message, $result){
        $this->http_code = $code;
        $this->http_message = $message;
        $this->result = $result;
        if(isset($result["error"]) && is_array($result["error"]) && isset($result["error"]["code"])){
            parent::__construct($result["error"]["code"], $result["error"]["message"], API_ERROR_TYPE);
        }else{
            parent::__construct($code, $message, API_ERROR_TYPE);
        }
    }
}
?>
