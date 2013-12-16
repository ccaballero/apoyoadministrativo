<?php

namespace Cidetsi\DepartamentosBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class CarreraController extends CrudController
{
    public $resource = 'carrera';
    public $repository = 'CidetsiDepartamentosBundle:Carrera';
    public $filterType = 'status';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\DepartamentosBundle\Form\CarreraForm';
    public $entity = 'Cidetsi\DepartamentosBundle\Entity\Carrera';

    public $tpl_commons = array(
        'title_list' => 'Carreras',
        'title_create' => 'Agregar carrera',
        'title_update' => 'Editar carrera',
        'title_delete' => 'Eliminar carrera',
        'url_list'     => 'carrera',
        'url_element'  => 'carrera_read',
    );
}
