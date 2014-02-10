<?php

namespace Cidetsi\DepartamentosBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;
use Cidetsi\DepartamentosBundle\Entity\Carrera;
use Cidetsi\DepartamentosBundle\Entity\PlanEstudio;
use Cidetsi\DepartamentosBundle\Form\CarreraForm;
use Cidetsi\DepartamentosBundle\Form\PlanEstudioForm;

use Symfony\Component\HttpFoundation\Request;

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

    public function readAction($id) {
        $entity = $this->getEntity($id);

        $em = $this->getDoctrine()->getManager();
        $docentes = $em->getRepository($this->repository)
                       ->findDocentes($entity);

        return $this->render($this->repository . ':read.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'docentes' => $docentes,
        )));
    }

    public function createCarreraGetAction($id) {
        $entity = $this->getEntity($id);

        $carrera = new Carrera();
        $form = $this->createCarreraCreateForm($entity, $carrera);

        return $this->render($this->repository . ':create.carrera.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    public function createCarreraPostAction(Request $request, $id) {
        $entity = $this->getEntity($id);
        
        $carrera = new Carrera();
        $carrera->setDepartamento($entity);

        $form = $this->createCarreraCreateForm($entity, $carrera);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($carrera);
            $em->flush();
 
            $this->get('session')->getFlashBag()
                 ->add('success', 'El recurso fue creado exitosamente');
            return $this->redirect(
                $this->generateUrl($this->resource . '_read', array(
                    'id' => $entity->getIdent())
            ));
        }

        return $this->render($this->repository . ':create.carrera.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    protected function createCarreraCreateForm($entity, $carrera) {
        $form = $this->createForm(new CarreraForm($entity), $carrera,
            array('action' => $this->generateUrl(
                'departamento_create_carrera_post', array(
                    'id' => $entity->getIdent(),
                )),
            'method' => 'POST',
        ));
        $form->add('submit', 'submit', array('label' => 'Agregar'));

        return $form;
    }

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
        $planestudio->setDepartamento($entity);

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
        $form = $this->createForm(new PlanEstudioForm($entity),
            $planestudio, array('action' => $this->generateUrl(
                'departamento_create_planestudio_post', array(
                    'id' => $entity->getIdent(),
                )),
            'method' => 'POST',
        ));
        $form->add('submit', 'submit', array('label' => 'Agregar'));

        return $form;
    }
}

