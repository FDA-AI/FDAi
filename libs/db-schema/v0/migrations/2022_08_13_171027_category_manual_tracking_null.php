<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('variable_categories', function (Blueprint $table) {
            $table->boolean('manual_tracking')->nullable()->change();
            //$table->integer('id')->unsigned()->change();
        });
    }

    public function down()
    {
        Schema::table('variable_categories', function (Blueprint $table) {

        });
    }
};
