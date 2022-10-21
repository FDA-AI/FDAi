<?php

use App\DataSources\QMConnector;
use App\Models\Connector;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('connectors', function (Blueprint $table) {
            $table->boolean('available_outside_us')->default(true);
            $table->unique([Connector::FIELD_NAME]);
        });
        //QMConnector::updateDatabaseTableFromHardCodedConstants();
    }

    public function down()
    {
        Schema::table('connectors', function (Blueprint $table) {

        });
    }
};
