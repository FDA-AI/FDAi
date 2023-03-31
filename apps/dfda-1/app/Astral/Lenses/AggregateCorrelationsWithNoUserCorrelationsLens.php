<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Astral\Lenses;
use App\Models\AggregateCorrelation;
use App\Models\BaseModel;
use Illuminate\Database\Eloquent\Builder;
use App\Http\Requests\LensRequest;
class AggregateCorrelationsWithNoUserCorrelationsLens extends AggregateCorrelationInvalidLens {
	public function name(): string{
		return "No User Correlations";
	}
	/**
	 * Get the query builder / paginator for the lens.
	 * @param LensRequest $request
	 * @param Builder $query
	 * @return mixed
	 */
	public static function query(LensRequest $request, $query){
		return $request->withOrdering($request->withFilters($query->where(AggregateCorrelation::FIELD_NUMBER_OF_CORRELATIONS,
				0)->orderBy(AggregateCorrelation::FIELD_ANALYSIS_STARTED_AT, BaseModel::ORDER_DIRECTION_DESC)));
	}
}
