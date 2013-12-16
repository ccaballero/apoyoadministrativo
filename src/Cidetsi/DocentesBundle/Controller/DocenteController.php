<?php

namespace Cidetsi\DocentesBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class DocenteController extends CrudController
{
    public $resource = 'docente';
    public $repository = 'CidetsiDocentesBundle:Docente';
    public $orderBy = array('apellido_paterno' => 'asc');
    public $form = 'Cidetsi\DocentesBundle\Form\DocenteForm';
    public $entity = 'Cidetsi\DocentesBundle\Entity\Docente';

    public $tpl_commons = array(
        'title_list'   => 'Docentes',
        'title_create' => 'Agregar docente',
        'title_update' => 'Editar docente',
        'title_delete' => 'Eliminar docente',
        'url_list'     => 'docente',
        'url_element'  => 'docente_read',
    );
}
