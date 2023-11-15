<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToVariablesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('variables', function (Blueprint $table) {
            $table->foreign(['best_global_variable_relationship_id'], 'variables_global_variable_relationships_id_fk')->references(['id'])->on('global_variable_relationships')->onUpdate('NO ACTION')->onDelete('SET NULL');
            $table->foreign(['best_cause_variable_id'], 'variables_best_cause_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('SET NULL');
            $table->foreign(['best_effect_variable_id'], 'variables_best_effect_variable_id_fk')->references(['id'])->on('variables')->onUpdate('NO ACTION')->onDelete('SET NULL');
            $table->foreign(['client_id'], 'variables_client_id_fk')->references(['client_id'])->on('oa_clients')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['default_unit_id'], 'variables_default_unit_id_fk')->references(['id'])->on('units')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['variable_category_id'], 'variables_variable_category_id_fk')->references(['id'])->on('variable_categories')->onUpdate('NO ACTION')->onDelete('NO ACTION');
            $table->foreign(['wp_post_id'], 'variables_wp_posts_ID_fk')->references(['ID'])->on('wp_posts')->onUpdate('CASCADE')->onDelete('SET NULL');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('variables', function (Blueprint $table) {
            $table->dropForeign('variables_global_variable_relationships_id_fk');
            $table->dropForeign('variables_best_cause_variable_id_fk');
            $table->dropForeign('variables_best_effect_variable_id_fk');
            $table->dropForeign('variables_client_id_fk');
            $table->dropForeign('variables_default_unit_id_fk');
            $table->dropForeign('variables_variable_category_id_fk');
            $table->dropForeign('variables_wp_posts_ID_fk');
        });
    }
}
