<?php

namespace Cidetsi\GestionesBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class GestionController extends CrudController
{
    public $resource = 'gestion';
    public $repository = 'CidetsiGestionesBundle:Gestion';
    public $orderBy = array('name' => 'asc');
    public $form = 'Cidetsi\GestionesBundle\Form\GestionForm';
    public $entity = 'Cidetsi\GestionesBundle\Entity\Gestion';

    public $tpl_commons = array(
        'title_list'   => 'Gestiones',
        'title_create' => 'Agregar gestión',
        'title_update' => 'Editar gestión',
        'title_delete' => 'Eliminar gestión',
        'url_list'     => 'gestion',
        'url_element'  => 'gestion_read',
    );
}
