<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Filters;

use Illuminate\Container\Container;
use Illuminate\Http\Request;

abstract class BooleanFilter extends Filter
{
    /**
     * The filter's component.
     *
     * @var string
     */
    public $component = 'boolean-filter';

    /**
     * Set the default options for the filter.
     *
     * @return array
     */
    public function default()
    {
        $container = Container::getInstance();

        return collect($this->options($container->make(Request::class)))->values()->mapWithKeys(function ($option) {
            return [$option => false];
        })->all();
    }
}
