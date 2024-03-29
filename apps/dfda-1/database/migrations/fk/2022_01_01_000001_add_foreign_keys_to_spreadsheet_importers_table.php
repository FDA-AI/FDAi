<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddForeignKeysToSpreadsheetImportersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('spreadsheet_importers', function (Blueprint $table) {
            $table->foreign(['client_id'], 'spreadsheet_importers_client_id_fk')->references(['client_id'])->on('oa_clients');
            $table->foreign(['wp_post_id'], 'spreadsheet_importers_wp_posts_ID_fk')->references(['ID'])->deferrable()->on('wp_posts');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('spreadsheet_importers', function (Blueprint $table) {
            $table->dropForeign('spreadsheet_importers_client_id_fk');
            $table->dropForeign('spreadsheet_importers_wp_posts_ID_fk');
        });
    }
}
