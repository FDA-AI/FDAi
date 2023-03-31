<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseInternalErrorMessageProperty;
class CorrelationInternalErrorMessageProperty extends BaseInternalErrorMessageProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public static function fixInvalidRecords(){
        QMLog::error(__METHOD__);
        CorrelationInternalErrorMessageProperty::whereQMQB("=", "0")
            ->update([Correlation::FIELD_INTERNAL_ERROR_MESSAGE => null]);
        $qb = Correlation::whereNotNull(Correlation::FIELD_INTERNAL_ERROR_MESSAGE)
            ->where(Correlation::FIELD_INTERNAL_ERROR_MESSAGE, "<>", "")
            ->withTrashed();
        $ids = $qb->pluck('id');
        $count = $ids->count();
        QMLog::error("$count invalid correlations with INTERNAL_ERROR_MESSAGE");
        foreach($ids as $id){
            $c = Correlation::findInMemoryOrDB($id);
            if(!$c){
                $c = Correlation::withTrashed()->where('id', $id)->first();
                if(!$c){
                    le("No correlation with id $id");
                } else {
                    $c->deleted_at = null;
                    $c->logError("was deleted");
                }
            }
            $user = $c->getUser();
            $user->logUrl();
            if(!$c->internal_error_message){
                le("No error message!");
            }
            $c->logError($c->internal_error_message);
            try {
                $c->analyze(__FUNCTION__);
                if($c->internal_error_message){
	                le(__METHOD__.": ".$c->internal_error_message);
                }
            } catch (\Throwable $e){
                QMLog::info(__METHOD__.": ".$e->getMessage());
                $c->forceDelete();
            }
        }
    }
}
