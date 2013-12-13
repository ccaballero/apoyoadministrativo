<?php

use Doctrine\Common\Annotations\AnnotationRegistry;
use Composer\Autoload\ClassLoader;

use Doctrine\DBAL\Types\Type;

/**
 * @var ClassLoader $loader
 */
$loader = require __DIR__.'/../vendor/autoload.php';

AnnotationRegistry::registerLoader(array($loader, 'loadClass'));

// doctrine register a enum type
Type::addType('status', 'Cidetsi\BaseBundle\Util\Types\Status');

return $loader;
