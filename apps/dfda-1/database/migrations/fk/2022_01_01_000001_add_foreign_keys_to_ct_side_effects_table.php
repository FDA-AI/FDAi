<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToCtSideEffectsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('ct_side_effects', function (Blueprint $table) {
            $table->foreign(['variable_id'], 'ct_side_effects_variables_id_fk')->references(['id'])->deferrable()->on('variables');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('ct_side_effects', function (Blueprint $table) {
            $table->dropForeign('ct_side_effects_variables_id_fk');
        });
    }
}
