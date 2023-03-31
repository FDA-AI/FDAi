<?php /** @var App\Models\Correlation $correlation */ ?>
@extends('layouts.admin-lte-email', ['title' => $correlation->getTitleAttribute() ])

@section('content')
   <div class="content">
        <div class="box box-primary">
            <div class="box-body">
                <div class="row" style="padding-left: 20px">
                    @include('datalab.correlations.show_fields')
                    <a href="{{ route('datalab.correlations.index') }}" class="btn btn-default">Back</a>
                </div>
            </div>
        </div>
    </div>
@endsection
