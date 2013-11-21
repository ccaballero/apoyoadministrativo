<?php

namespace Cidetsi\TestBundle\Tests\Routing;

use Cidetsi\TestBundle\Tests\Routing\Generic\StaticTest;

class RoutingTest extends StaticTest
{
    public function getRoutes() {
        return array(
            array('/'),
            array('/acceder'),
        );
    }
}
