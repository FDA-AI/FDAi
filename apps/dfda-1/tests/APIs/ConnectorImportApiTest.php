<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\UnitTestCase;
use Tests\ApiTestTrait;
use App\Models\ConnectorImport;

class ConnectorImportApiTest extends UnitTestCase
{
    use ApiTestTrait;
    public function setUp(): void
    {
        $this->markTestSkipped('Not implemented yet.');
        parent::setUp(); // TODO: Change the autogenerated stub
    }

    public function test_create_connector_import()
    {
        $this->markTestSkipped('Not implemented yet.');
        $connectorImport = ConnectorImport::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'POST',
            '/api/v6/connector_imports', $connectorImport
        );

        $this->assertApiResponse($connectorImport);
    }

    public function test_read_connector_import()
    {
        $connectorImport = ConnectorImport::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/connector_imports/'.$connectorImport->id
        );

        $this->assertApiResponse($connectorImport->toArray());
    }

    public function test_update_connector_import()
    {
        $connectorImport = ConnectorImport::fakeSaveFromPropertyModels();
        $editedConnectorImport = ConnectorImport::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'PUT',
            '/api/v6/connector_imports/'.$connectorImport->id,
            $editedConnectorImport
        );

        $this->assertApiResponse($editedConnectorImport);
    }

    public function test_delete_connector_import()
    {
        $connectorImport = ConnectorImport::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'DELETE',
             '/api/v6/connector_imports/'.$connectorImport->id
         );

        $this->assertApiSuccess();
        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/connector_imports/'.$connectorImport->id
        );

        $this->testResponse->assertStatus(404);
    }
}