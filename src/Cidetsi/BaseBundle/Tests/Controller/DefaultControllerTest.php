<?php

namespace Cidetsi\TestBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class DefaultControllerTest extends WebTestCase
{
    protected $client;

    protected function setUp() {
        $this->client = static::createClient();
    }

    /**
     * @dataProvider getRoutes
     */
    public function testRouting($request) {
        $this->client->request('GET', $request);
        $response = $this->client->getResponse();

        $this->assertTrue($this->isSuccessful($response));
        $this->assertEquals(200, $this->getStatusCode($response));
    }

    protected function isSuccessful($response) {
        return $response->isSuccessful();
    }

    protected function getStatusCode($response) {
        return $response->getStatusCode();
    }

    public function getRoutes() {
        return array(
            array('/'),
            array('/acceder'),
        );
    }
}
