<?php

namespace Cidetsi\DepartamentosBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class DepartamentoController extends CrudController
{
    public $resource = 'departamento';
    public $repository = 'CidetsiDepartamentosBundle:Departamento';
    public $filterType = 'status';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\DepartamentosBundle\Form\DepartamentoForm';
    public $entity = 'Cidetsi\DepartamentosBundle\Entity\Departamento';

    public $tpl_commons = array(
        'title_list'   => 'Departamentos',
        'title_create' => 'Agregar departamento',
        'title_update' => 'Editar departamento',
        'title_delete' => 'Eliminar departamento',
        'url_list'     => 'departamento',
        'url_element'  => 'departamento_read',
    );
}
