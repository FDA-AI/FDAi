<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\UnitTestCase;
use Tests\ApiTestTrait;
use App\Models\CommonTag;

class CommonTagApiTest extends UnitTestCase
{
    use ApiTestTrait;
    public function setUp(): void
    {
        $this->markTestSkipped('Not implemented yet.');
        parent::setUp(); // TODO: Change the autogenerated stub
    }

    public function test_create_common_tag()
    {
        $this->markTestSkipped('Not implemented yet.');
        $commonTag = CommonTag::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'POST',
            '/api/v6/common_tags', $commonTag
        );

        $this->assertApiResponse($commonTag);
    }

    public function test_read_common_tag()
    {
        $commonTag = CommonTag::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/common_tags/'.$commonTag->id
        );

        $this->assertApiSuccess();
        $responseData = $this->getDecodedResponseContent();
        $this->assertArrayEquals([], $responseData);
    }

    public function test_update_common_tag()
    {
        $commonTag = CommonTag::fakeSaveFromPropertyModels();
        $editedCommonTag = CommonTag::factory()->make()->toArray();

        $r = $this->jsonAsUser18535(
            'PUT',
            '/api/v6/common_tags/'.$commonTag->id,
            $editedCommonTag
        );

        $this->assertApiResponse($editedCommonTag);
    }

    public function test_delete_common_tag()
    {
        $commonTag = CommonTag::fakeSaveFromPropertyModels();

        $r = $this->jsonAsUser18535(
            'DELETE',
             '/api/v6/common_tags/'.$commonTag->id
         );

        $this->assertApiSuccess();
        $r = $this->jsonAsUser18535(
            'GET',
            '/api/v6/common_tags/'.$commonTag->id
        );

        $this->testResponse->assertStatus(404);
    }
}
