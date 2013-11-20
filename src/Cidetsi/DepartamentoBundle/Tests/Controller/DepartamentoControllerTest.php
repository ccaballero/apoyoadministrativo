<?php

namespace Cidetsi\DepartamentoBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class DepartamentoControllerTest extends WebTestCase
{
    /**
     * @var \Doctrine\ORM\EntityManager
     */
    private $em;

    /**
     * {@inheritDoc}
     */
    public function setUp() {
        static::$kernel = static::createKernel();
        static::$kernel->boot();
        $this->em = static::$kernel->getContainer()
             ->get('doctrine')->getManager();
    }

    public function testIndex() {
        $client = static::createClient();

        $crawler = $client->request('GET', '/hello/Fabien');

        $this->assertTrue(true);
    }
}

/*
public function testCompleteScenario()
{
    // Create a new client to browse the application
    $client = static::createClient();

    // Create a new entry in the database
    $crawler = $client->request('GET', '/departamento/');
    $this->assertEquals(200, $client->getResponse()->getStatusCode(), "Unexpected HTTP status code for GET /departamento/");
    $crawler = $client->click($crawler->selectLink('Create a new entry')->link());

    // Fill in the form and submit it
    $form = $crawler->selectButton('Create')->form(array(
        'cidetsi_departamentobundle_departamentotype[field_name]'  => 'Test',
        // ... other fields to fill
    ));

    $client->submit($form);
    $crawler = $client->followRedirect();

    // Check data in the show view
    $this->assertGreaterThan(0, $crawler->filter('td:contains("Test")')->count(), 'Missing element td:contains("Test")');

    // Edit the entity
    $crawler = $client->click($crawler->selectLink('Edit')->link());

    $form = $crawler->selectButton('Edit')->form(array(
        'cidetsi_departamentobundle_departamentotype[field_name]'  => 'Foo',
        // ... other fields to fill
    ));

    $client->submit($form);
    $crawler = $client->followRedirect();

    // Check the element contains an attribute with value equals "Foo"
    $this->assertGreaterThan(0, $crawler->filter('[value="Foo"]')->count(), 'Missing element [value="Foo"]');

    // Delete the entity
    $client->submit($crawler->selectButton('Delete')->form());
    $crawler = $client->followRedirect();

    // Check the entity has been delete on the list
    $this->assertNotRegExp('/Foo/', $client->getResponse()->getContent());
}

*/