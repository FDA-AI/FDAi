@extends('layouts.admin-lte-app', ['title' => 'Aggregate Correlations' ])

@section('content')
    <section class="content-header">
        <h1>
            Aggregate Correlation
        </h1>
         @include('single-model-menu-button')
   </section>
   <div class="content">
        @include('adminlte-templates::common.errors')
        <div class="box box-primary">
            <div class="box-body">
                <div class="row">
                    {!! Form::open(['route' => 'datalab.aggregateCorrelations.store']) !!}

                        @include('datalab.aggregate_correlations.fields')

                    {!! Form::close() !!}
                </div>
            </div>
        </div>
    </div>
@endsection
