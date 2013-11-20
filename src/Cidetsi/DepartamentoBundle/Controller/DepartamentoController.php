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

    public $tpl_commons = array(
        'title_list'   => 'Departamentos',
        'title_create' => 'Agregar departamento',
        'title_update' => 'Editar departamento',
        'title_delete' => 'Eliminar departamento',
        'url_list'     => 'departamento',
        'url_element'  => 'departamento_read',
    );
}
