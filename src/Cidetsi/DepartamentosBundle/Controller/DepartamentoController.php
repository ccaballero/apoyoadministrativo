<?php

namespace Cidetsi\DepartamentosBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class DepartamentoController extends CrudController
{
    public $resource = 'departamento';
    public $repository = 'CidetsiDepartamentosBundle:Departamento';
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

//    public function readAction($id) {
//        $em = $this->getDoctrine()->getManager();
//        $entity = $em->getRepository($this->repository)->find($id);
//        if (!$entity) {
//            throw $this->createNotFoundException('Unable to find entity.');
//        }
//        if ($entity->getStatus() == 'disabled') {
//            throw $this->createNotFoundException('The entity is disabled.');
//        }
//        
//        return $this->render($this->repository . ':read.html.twig',
//            array_merge(
//                $this->tpl_commons, array(
//                    'entity' => $entity,
//        )));
//    }
}
