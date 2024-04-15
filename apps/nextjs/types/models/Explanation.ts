/**
 * Decentralized FDA API
 * A platform for quantifying the effects of every drug, supplement, food, and other factor on your health.
 *
 * OpenAPI spec version: 0.0.1
 *
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

import { ExplanationStartTracking } from '../models/ExplanationStartTracking';
import { Image } from '../models/Image';
import { HttpFile } from '../http/http';

export class Explanation {
    /**
    * Ex: These factors are most predictive of Overall Mood based on your own data.
    */
    'description': string;
    'image': Image;
    /**
    * Ex: ion-ios-person
    */
    'ionIcon': string;
    'startTracking': ExplanationStartTracking;
    /**
    * Ex: Top Predictors of Overall Mood
    */
    'title': string;
    /**
    * Embeddable list of study summaries with explanation at the top
    */
    'html'?: string;

    static readonly discriminator: string | undefined = undefined;

    static readonly attributeTypeMap: Array<{name: string, baseName: string, type: string, format: string}> = [
        {
            "name": "description",
            "baseName": "description",
            "type": "string",
            "format": ""
        },
        {
            "name": "image",
            "baseName": "image",
            "type": "Image",
            "format": ""
        },
        {
            "name": "ionIcon",
            "baseName": "ionIcon",
            "type": "string",
            "format": ""
        },
        {
            "name": "startTracking",
            "baseName": "startTracking",
            "type": "ExplanationStartTracking",
            "format": ""
        },
        {
            "name": "title",
            "baseName": "title",
            "type": "string",
            "format": ""
        },
        {
            "name": "html",
            "baseName": "html",
            "type": "string",
            "format": ""
        }    ];

    static getAttributeTypeMap() {
        return Explanation.attributeTypeMap;
    }

    public constructor() {
    }
}
