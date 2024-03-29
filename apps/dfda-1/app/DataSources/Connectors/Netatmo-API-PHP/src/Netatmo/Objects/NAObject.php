<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace Netatmo\Objects;
/** NAObject Class
 * Abstact class, parent of every objects
 */
abstract class NAObject {
    protected $object = [];
    /**
     * NAObject constructor.
     * @param $array
     */
    public function __construct($array){
        $this->object = $array;
    }
    /**
     * @param string field : array key
     * @param $default : default value in case field is not set
     * @return object field or default if field is not set
     * @brief returns an object's field
     */
    public function getVar($field, $default = NULL){
        return $this->object[$field] ?? $default;
    }
    /**
     * @param string $field : field to be set
     * @param $value value to set to field
     * @brief set an object's field
     */
    public function setVar($field, $value){
        $this->object[$field] = $value;
    }
    /**
     * @return id
     * @btief returns object id
     */
    public function getId(){
        return $this->getVar("id");
    }
    /**
     * @return array $object
     * @brief return this object as an array
     */
    public function toArray(){
        return $this->object;
    }
    /**
     * @return JSON document
     * @brief returns object as a JSON document
     */
    public function toJson(){
        return json_encode($this->toArray());
    }
    /**
     * @return string
     * @brief return string representation of object : JSON doc
     */
    public function __toString() {
        /** @noinspection MagicMethodsValidityInspection */
        return $this->toJson();
    }
}
?>
