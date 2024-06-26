<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Http\Requests;

trait InteractsWithLenses
{
    /**
     * Get the lens instance for the given request.
     *
     * @return \App\Lenses\Lens
     */
    public function lens()
    {
        return $this->availableLenses()->first(function ($lens) {
            return $this->lens === $lens->uriKey();
        }) ?: abort($this->lensExists() ? 403 : 404);
    }

    /**
     * Get all of the possible lenses for the request.
     *
     * @return \Illuminate\Support\Collection
     */
    public function availableLenses()
    {
        return $this->newResource()->availableLenses($this);
    }

    /**
     * Determine if the specified action exists at all.
     *
     * @return bool
     */
    protected function lensExists()
    {
        return $this->newResource()->resolveLenses($this)->contains(function ($lens) {
            return $this->lens === $lens->uriKey();
        });
    }
}
