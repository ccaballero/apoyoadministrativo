<?php

namespace Cidetsi\DepartamentosBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;
use Cidetsi\DepartamentosBundle\Entity\PlanEstudio;
use Cidetsi\DepartamentosBundle\Form\PlanEstudioForm;

use Symfony\Component\HttpFoundation\Request;

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

    public function createPlanEstudioGetAction($id) {
        $entity = $this->getEntity($id);

        $planestudio = new PlanEstudio();
        $form = $this->createPlanEstudioCreateForm($entity, $planestudio);

        return $this->render($this->repository
            . ':create.planestudio.html.twig', array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    public function createPlanEstudioPostAction(Request $request, $id) {
        $entity = $this->getEntity($id);
        
        $planestudio = new PlanEstudio();
        $planestudio->setCarrera($entity);
        $planestudio->setDepartamento($entity->getDepartamento());

        $form = $this->createPlanEstudioCreateForm($entity, $planestudio);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($planestudio);
            $em->flush();
 
            $this->get('session')->getFlashBag()
                 ->add('success', 'El recurso fue creado exitosamente');
            return $this->redirect(
                $this->generateUrl($this->resource . '_read', array(
                    'id' => $entity->getIdent())
            ));
        }

        return $this->render($this->repository
            . ':create.planestudio.html.twig', array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    protected function createPlanEstudioCreateForm($entity, $planestudio) {
        $form = $this->createForm(new PlanEstudioForm(
            $entity->getDepartamento(), $entity),
            $planestudio, array('action' => $this->generateUrl(
                'carrera_create_planestudio_post', array(
                    'id' => $entity->getIdent(),
                )),
            'method' => 'POST',
        ));
        $form->add('submit', 'submit', array('label' => 'Agregar'));

        return $form;
    }
}

