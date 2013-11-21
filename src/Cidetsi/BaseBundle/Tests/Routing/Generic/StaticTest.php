<?php

namespace Cidetsi\TestBundle\Tests\Routing\Generic;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

abstract class StaticTest extends WebTestCase
{
    protected $client;

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    protected $em;

    /**
     * {@inheritDoc}
     */
    protected function setUp() {
        $this->client = static::createClient();

        static::$kernel = static::createKernel();
        static::$kernel->boot();
        $this->em = static::$kernel->getContainer()
             ->get('doctrine')->getManager();
    }

    /**
     * {@inheritDoc}
     */
    protected function tearDown() {
        parent::tearDown();
        $this->em->close();
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

    abstract public function getRoutes();
}
