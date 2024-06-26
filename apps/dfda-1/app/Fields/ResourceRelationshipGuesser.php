<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Fields;

use Illuminate\Foundation\Application;
use Illuminate\Support\Str;

class ResourceRelationshipGuesser
{
    /**
     * Guess the resource class name from the displayable name.
     *
     * @param  string  $name
     * @return string
     */
    public static function guessResource($name)
    {
        $singular = Str::studly(Str::singular($name));

        if (class_exists($appResource = Application::getInstance()->getNamespace().'Astral\\'.$singular)) {
            return $appResource;
        }

        $results = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 4);

        return str_replace(
            class_basename($results[3]['class']),
            $singular,
            $results[3]['class']
        );
    }
}
