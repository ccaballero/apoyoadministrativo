<?php

namespace Cidetsi\BaseBundle\Util\Types;

class Status extends Enum
{
    protected $name = 'status';
    protected $values = array('enabled', 'disabled');
}
