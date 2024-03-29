<?php

return [

    /*
     |--------------------------------------------------------------------------
     | Site default title
     |--------------------------------------------------------------------------
     |
     */

    'title' => env('APP_NAME', 'Awesome FDA'),

    /*
     |--------------------------------------------------------------------------
     | Limit title meta tag length
     |--------------------------------------------------------------------------
     |
     | To best SEO implementation, limit tags.
     |
     */

    'title_limit' => 70,

    /*
     |--------------------------------------------------------------------------
     | Limit description meta tag length
     |--------------------------------------------------------------------------
     |
     | To best SEO implementation, limit tags.
     |
     */

    'description_limit' => 200,

    /*
     |--------------------------------------------------------------------------
     | OpenGraph values
     |--------------------------------------------------------------------------
     |
     */

    'open_graph' => [
        'site_name' => env('APP_NAME', 'Awesome FDA'),
        'type' => 'website'
    ],

    /*
     |--------------------------------------------------------------------------
     | Twitter Card values
     |--------------------------------------------------------------------------
     |
     */

    'twitter' => [
        'card' => 'summary',
        'creator' => '@quantimodo',
        'site' => '@quantimodo'
    ],

    /*
     |--------------------------------------------------------------------------
     | Supported languages
     |--------------------------------------------------------------------------
     |
     */

    'locale_url' => '[scheme]://[locale][host][uri]',

    /*
     |--------------------------------------------------------------------------
     | Supported languages
     |--------------------------------------------------------------------------
     |
     */

    'locales' => ['en', 'es'],
];
