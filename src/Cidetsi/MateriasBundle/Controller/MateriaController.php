<?php

namespace Cidetsi\MateriasBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class MateriaController extends CrudController
{
    public $resource = 'materia';
    public $repository = 'CidetsiMateriasBundle:Materia';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\MateriasBundle\Form\MateriaForm';
    public $entity = 'Cidetsi\MateriasBundle\Entity\Materia';

    public $tpl_commons = array(
        'title_list'   => 'Materias',
        'title_create' => 'Agregar materia',
        'title_update' => 'Editar materia',
        'title_delete' => 'Eliminar materia',
        'url_list'     => 'materia',
        'url_element'  => 'materia_read',
    );
}
