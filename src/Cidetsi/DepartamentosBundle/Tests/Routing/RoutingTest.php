<?php

namespace Cidetsi\DepartamentosBundle\Tests\Routing;

use Cidetsi\TestBundle\Tests\Routing\Generic\CrudTest;

class RoutingTest extends CrudTest
{
    public function getRoutes() {
        return array(
            array('/departamento/'),
            array('/departamento/agregar'),
            array('/carrera/'),
            array('/carrera/agregar'),
        );
    }

    public function getRepository() {
        return 'CidetsiDepartamentosBundle:Departamento';
    }

    public function getOperations() {
        return array(
            'departamento_read',
            'departamento_update_get',
            'departamento_delete_get',
        );
    }

//
//    // testing view-edit-delete request for enabled pages
//    public function testCrudOperations() {
//        $departamentos = $this->em
//            ->getRepository('CidetsiDepartamentosBundle:Departamento')
//            ->findBy(array('status' => 'enabled'));
//
//        foreach ($departamentos as $departamento) {
//            $url = $this->getRoute($departamento);
//            $this->testRouting($url);
//        }
//    }
//
//    protected function getRoute($entity) {
//        return $this->client->getContainer()->get('router')
//                    ->generate(
//                        'departamento_read', array(
//                            'id' => $entity->getId()));
//    }
}