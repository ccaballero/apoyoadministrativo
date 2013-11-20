<?php

namespace Cidetsi\DepartamentoBundle\Tests\Controller;

class DefaultControllerTest
    extends \Cidetsi\TestBundle\Tests\Controller\DefaultControllerTest
{
    public function getRoutes() {
        return array(
            array('/departamento/'),
            array('/departamento/agregar'),
        );
    }
}
