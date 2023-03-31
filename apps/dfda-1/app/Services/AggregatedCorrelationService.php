<?php namespace App\Services;
use App\Models\AggregateCorrelation;
use App\Storage\QueryBuilderHelper;
use Illuminate\Database\Eloquent\Collection;
class AggregatedCorrelationService extends BaseService {
    /**
     * @param array $filters
     * @return AggregateCorrelation[]|Collection
     */
    public function all($filters = []){
        $query = AggregateCorrelation::with([
            'cause',
            'effect'
        ]);
        QueryBuilderHelper::applyFilters($query->getQuery(), $filters);
        QueryBuilderHelper::applyOffsetLimitSort($query->getQuery(), $filters);
        return $query->get();
    }
    /**
     * @param array $input
     * @return AggregateCorrelation
     */
    public function create(array $input){
        return AggregateCorrelation::create($input);
    }
    /**
     * @param int $id
     * @param array $columns
     * @return null|AggregateCorrelation
     */
    public function find($id, $columns = ['*']){
        return AggregateCorrelation::find($id, $columns);
    }
    /**
     * @param int $id
     * @return null|AggregateCorrelation
     */
    public function getWithRelations($id){
        return AggregateCorrelation::whereId($id)->with([
            'cause',
            'effect'
        ])->first();
    }
    /**
     * @param array $data
     * @param int $id
     * @return bool
     */
    public function updateRich(array $data, $id){
        if(!($aggregatedCorrelation = $this->find($id))){
            return false;
        }
        return $aggregatedCorrelation->fill($data)->save();
    }
    /**
     * @param int $id
     * @return bool|null
     */
    public function delete($id){
        if(!($aggregatedCorrelation = $this->find($id))){
            return false;
        }
        return $aggregatedCorrelation->delete();
    }
}/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */


