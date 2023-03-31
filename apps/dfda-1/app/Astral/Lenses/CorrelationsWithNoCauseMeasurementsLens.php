<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Astral\Lenses;
use App\Models\BaseModel;
use App\Models\Correlation;
use Illuminate\Database\Eloquent\Builder;
use App\Http\Requests\LensRequest;
class CorrelationsWithNoCauseMeasurementsLens extends CorrelationInvalidLens {
	public function name(): string{
		return "No Cause Measurements";
	}
	/**
	 * Get the query builder / paginator for the lens.
	 * @param LensRequest $request
	 * @param Builder $query
	 * @return mixed
	 */
	public static function query(LensRequest $request, $query){
		return $request->withOrdering($request->withFilters($query
			//                ->select( [
			//                    Correlation::FIELD_ID,
			//                    Correlation::FIELD_ANALYSIS_STARTED_AT,
			//                    Correlation::FIELD_INTERNAL_ERROR_MESSAGE,
			//                ])
			->whereNotNull(Correlation::FIELD_INTERNAL_ERROR_MESSAGE)
			->where(Correlation::FIELD_CAUSE_NUMBER_OF_PROCESSED_DAILY_MEASUREMENTS, 0)
			->orderBy(Correlation::FIELD_ANALYSIS_STARTED_AT, BaseModel::ORDER_DIRECTION_DESC)));
	}
}
