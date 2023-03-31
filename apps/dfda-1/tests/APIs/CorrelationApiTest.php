<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\APIs;

use App\Storage\DB\TestDB;
use Tests\UnitTestCase;
use Tests\ApiTestTrait;
use App\Models\Correlation;

class CorrelationApiTest extends UnitTestCase
{
    use ApiTestTrait;
    public function test_create_correlation()
    {
        $this->skipTest('Not implemented yet.');
        $correlation = Correlation::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'POST',
            '/api/v6/correlations', $correlation
        );

        $this->assertApiResponse($correlation);
    }
	public function test_read_correlation()
    {
	    //$this->resetSQLiteDB();
	    $correlation = Correlation::firstOrFakeSave();
		$found = Correlation::find($correlation->id);
		$this->assertNotNull($found);
		$this->assertGuest();
		$this->expectUnauthorizedException();
		$this->getApiV6('correlations');
		$this->setAuthenticatedUser(1);
        $r = $this->getJson(
            '/api/v6/correlations/'.$correlation->id
        );
        $this->assertApiResponse($correlation->toArray());
		$this->setAuthenticatedUser($correlation->user_id);
	    $correlation->causality_vote = 1;
	    $correlation->save();
	    $r = $this->putJson('/api/v6/correlations/'.$correlation->id, [Correlation::FIELD_CAUSALITY_VOTE => -1]);
	    $r->assertStatus(201);
		$updated = Correlation::find($correlation->id);
	    $this->assertEquals(-1, $updated->causality_vote);
	    $this->setAuthenticatedUser($correlation->user_id);
	    $correlation->causality_vote = 1;
        $r = $this->json(
            'DELETE',
             '/api/v6/correlations/'.$correlation->id
         );
	    $r->assertStatus(204);
	    $this->expectModelNotFoundException();
        $r = $this->json(
            'GET',
            '/api/v6/correlations/'.$correlation->id
        );
	    $r->assertStatus(404);
    }
}
