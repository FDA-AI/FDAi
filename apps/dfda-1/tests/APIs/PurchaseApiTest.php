<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\UnitTestCase;
use Tests\ApiTestTrait;
use App\Models\Purchase;

class PurchaseApiTest extends UnitTestCase
{
    use ApiTestTrait;
    public function setUp(): void
    {
        $this->markTestSkipped('Not implemented yet.');
        parent::setUp(); // TODO: Change the autogenerated stub
    }

    public function test_create_purchase()
    {
        $purchase = Purchase::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'POST',
            '/api/v6/purchases', $purchase
        );

        $this->assertApiResponse($purchase);
    }

    public function test_read_purchase()
    {
        $purchase = Purchase::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/purchases/'.$purchase->id
        );

        $this->assertApiResponse($purchase->toArray());
    }

    public function test_update_purchase()
    {
        $purchase = Purchase::fakeSaveFromPropertyModels();
        $editedPurchase = Purchase::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'PUT',
            '/api/v6/purchases/'.$purchase->id,
            $editedPurchase
        );

        $this->assertApiResponse($editedPurchase);
    }

    public function test_delete_purchase()
    {
        $purchase = Purchase::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'DELETE',
             '/api/v6/purchases/'.$purchase->id
         );

        $this->assertApiSuccess();
        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/purchases/'.$purchase->id
        );

        $this->testResponse->assertStatus(404);
    }
}
