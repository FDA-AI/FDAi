<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Http\Requests;

use App\Astral;
use App\AstralResource;

trait InteractsWithRelatedResources
{
    /**
     * Find the parent resource model instance for the request.
     *
     * @return \App\AstralResource
     */
    public function findParentResourceOrFail()
    {
        return once(function () {
            $resource = $this->viaResource();

            return new $resource($this->findParentModelOrFail());
        });
    }

    /**
     * Find the parent resource model instance for the request.
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function findParentModel()
    {
        return once(function () {
            if (! $this->viaRelationship()) {
                return;
            }

            return Astral::modelInstanceForKey($this->viaResource)
                                ->newQueryWithoutScopes()
                                ->find($this->viaResourceId);
        });
    }

    /**
     * Find the parent resource model instance for the request or abort.
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function findParentModelOrFail()
    {
        return $this->findParentModel() ?: abort(404);
    }

    /**
     * Find the parent resource model instance for the request.
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function findRelatedModel()
    {
        return once(function () {
            return Astral::modelInstanceForKey($this->relatedResource)
                ->newQueryWithoutScopes()
                ->find($this->input($this->relatedResource));
        });
    }

    /**
     * Find the parent resource model instance for the request or abort.
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function findRelatedModelOrFail()
    {
        return $this->findRelatedModel() ?: abort(404);
    }

    /**
     * Get the displayable pivot model name for a "via relationship" request.
     *
     * @return string
     */
    public function pivotName()
    {
        if (! $this->viaRelationship()) {
            return AstralResource::DEFAULT_PIVOT_NAME;
        }

        $resource = Astral::resourceInstanceForKey($this->viaResource);

        if ($name = $resource->pivotNameForField($this, $this->viaRelationship)) {
            return $name;
        }

        return ($parent = $this->findParentModel())
                    ? class_basename($parent->{$this->viaRelationship}()->getPivotClass())
                    : AstralResource::DEFAULT_PIVOT_NAME;
    }

    /**
     * Get a new instance of the "via" resource being requested.
     *
     * @return \App\AstralResource
     */
    public function newViaResource()
    {
        $resource = $this->viaResource();

        return new $resource($resource::newModel());
    }

    /**
     * Get the class name of the "related" resource being requested.
     *
     * @return string
     */
    public function relatedResource()
    {
        return Astral::resourceForKey($this->relatedResource);
    }

    /**
     * Get a new instance of the "related" resource being requested.
     *
     * @return \App\AstralResource
     */
    public function newRelatedResource()
    {
        $resource = $this->relatedResource();

        return new $resource($resource::newModel());
    }

    /**
     * Get the class name of the "via" resource being requested.
     *
     * @return string
     */
    public function viaResource()
    {
        return Astral::resourceForKey($this->viaResource);
    }

    /**
     * Determine if the request is via a relationship.
     *
     * @return bool
     */
    public function viaRelationship()
    {
        return $this->viaResource && $this->viaResourceId && $this->viaRelationship;
    }
}
