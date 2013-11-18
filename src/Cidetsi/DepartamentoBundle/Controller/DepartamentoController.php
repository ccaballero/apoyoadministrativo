<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class DepartamentoController extends CrudController
{
    public $resource = 'departamento';
    public $repository = 'CidetsiDepartamentoBundle:Departamento';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\DepartamentoBundle\Form\DepartamentoForm';
    public $entity = 'Cidetsi\DepartamentoBundle\Entity\Departamento';
}
