<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class CarreraController extends CrudController
{
    public $resource = 'carrera';
    public $repository = 'CidetsiDepartamentoBundle:Carrera';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\DepartamentoBundle\Form\CarreraForm';
    public $entity = 'Cidetsi\DepartamentoBundle\Entity\Carrera';

    public $tpl_commons = array(
        'title_list' => 'Carreras',
    );
}
