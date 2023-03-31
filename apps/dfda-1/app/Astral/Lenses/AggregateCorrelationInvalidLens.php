<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Astral\Lenses;
use App\Astral\Metrics\InvalidAnalyzablesPartition;
use App\Astral\BaseAstralAstralResource;
use App\Properties\AggregateCorrelation\AggregateCorrelationAnalysisStartedAtProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationCauseVariableCategoryIdProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationEffectFollowUpPercentChangeFromBaselineProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationEffectVariableCategoryIdProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationIdProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationInternalErrorMessageProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationNumberOfCorrelationsProperty;
use Illuminate\Http\Request;
use App\Http\Requests\AstralRequest;
abstract class AggregateCorrelationInvalidLens extends FailedAnalysesLens {
	/**
	 * Get the fields displayed by the resource.
	 * @param Request|AstralRequest $request
	 * @return array
	 */
	public function fields(Request $request): array{
		/** @var BaseAstralAstralResource $res */
		$res = $request->newResourceWith($this->resource);
		$fields[] = $res->getNameField();
		$fields[] = AggregateCorrelationEffectFollowUpPercentChangeFromBaselineProperty::field(null, null);
		$fields[] = AggregateCorrelationNumberOfCorrelationsProperty::field(null, null);
		$fields[] = AggregateCorrelationCauseVariableCategoryIdProperty::field(null, null);
		$fields[] = AggregateCorrelationEffectVariableCategoryIdProperty::field(null, null);
		$fields[] = AggregateCorrelationAnalysisStartedAtProperty::field(null, null);
		$fields[] = AggregateCorrelationInternalErrorMessageProperty::field(null, null);
		// Need ID for deletion https://astral.laravel.com/docs/3.0/lenses/defining-lenses.html
		$fields[] = AggregateCorrelationIdProperty::field(null, null);
		return $fields;
	}
	public function cards(Request $request): array{
		return [
			new InvalidAnalyzablesPartition(AggregateCorrelationEffectFollowUpPercentChangeFromBaselineProperty::class),
		];
	}
}
