<?php

namespace Cidetsi\TestBundle\Tests\Routing\Generic;

use Cidetsi\TestBundle\Tests\Routing\Generic\StaticTest;

abstract class CrudTest extends StaticTest
{
    // testing view-edit-delete get request for enabled pages
    public function testCrudOperations() {
        $entities = $this->em
            ->getRepository($this->getRepository())
            ->findBy(array('status' => 'enabled'));

        foreach ($entities as $entity) {
            foreach ($this->getOperations() as $route) {
                $url = $this->getRoute($entity, $route);
                $this->testRouting($url);
            }
        }
    }

    protected function getRoute($entity, $route) {
        return $this->client->getContainer()->get('router')
                    ->generate($route, array('id' => $entity->getId()));
    }

    abstract public function getRepository();
    abstract public function getOperations();
}