<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('wp_users', function (Blueprint $table) {
            $table->string('eth_address')->index()->nullable();
        });
    }

    public function down()
    {
        Schema::table('wp_users', function (Blueprint $table) {

        });
    }
};
