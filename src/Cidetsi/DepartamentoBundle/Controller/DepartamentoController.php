<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

use Cidetsi\DepartamentoBundle\Entity\Departamento;
use Cidetsi\DepartamentoBundle\Form\DepartamentoType;

class DepartamentoController extends Controller
{
    public function indexAction() {
        $em = $this->getDoctrine()->getManager();
        $entities = $em->getRepository('CidetsiDepartamentoBundle:Departamento')
                       ->findBy(array(), array('name' => 'asc'));

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:index.html.twig', array(
                'entities' => $entities,
        ));
    }

    public function newAction() {
        $entity = new Departamento();
        $form   = $this->createCreateForm($entity);

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:new.html.twig', array(
                'entity' => $entity,
                'form'   => $form->createView(),
        ));
    }

    public function createAction(Request $request) {
        $entity = new Departamento();
        $form = $this->createCreateForm($entity);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($entity);
            $em->flush();

            return $this->redirect(
                $this->generateUrl('departamento_show', array(
                    'id' => $entity->getId())
            ));
        }

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:new.html.twig', array(
                'entity' => $entity,
                'form'   => $form->createView(),
        ));
    }

    private function createCreateForm(Departamento $entity) {
        $form = $this->createForm(new DepartamentoType(), $entity, array(
            'action' => $this->generateUrl('departamento_create'),
            'method' => 'POST',
        ));

        $form->add('submit', 'submit', array('label' => 'Agregar'));

        return $form;
    }

    public function showAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository('CidetsiDepartamentoBundle:Departamento')
                     ->find($id);

        if (!$entity) {
            throw $this->createNotFoundException(
                'Unable to find Departamento entity.');
        }

        $deleteForm = $this->createDeleteForm($id);

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:show.html.twig', array(
                'entity'      => $entity,
                'delete_form' => $deleteForm->createView(),
        ));
    }

    public function editAction($id) {
        $em = $this->getDoctrine()->getManager();

        $entity = $em->getRepository('CidetsiDepartamentoBundle:Departamento')
                     ->find($id);

        if (!$entity) {
            throw $this->createNotFoundException(
                'Unable to find Departamento entity.');
        }

        $editForm = $this->createEditForm($entity);
        $deleteForm = $this->createDeleteForm($id);

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:edit.html.twig', array(
                'entity'      => $entity,
                'edit_form'   => $editForm->createView(),
                'delete_form' => $deleteForm->createView(),
        ));
    }

    private function createEditForm(Departamento $entity) {
        $form = $this->createForm(new DepartamentoType(), $entity, array(
            'action' => $this->generateUrl(
                'departamento_update', array('id' => $entity->getId())),
            'method' => 'PUT',
        ));

        $form->add('submit', 'submit', array('label' => 'Update'));
        return $form;
    }

    public function updateAction(Request $request, $id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository('CidetsiDepartamentoBundle:Departamento')
                     ->find($id);

        if (!$entity) {
            throw $this->createNotFoundException(
                'Unable to find Departamento entity.');
        }

        $deleteForm = $this->createDeleteForm($id);
        $editForm = $this->createEditForm($entity);
        $editForm->handleRequest($request);

        if ($editForm->isValid()) {
            $em->flush();

            return $this->redirect(
                $this->generateUrl('departamento_edit', array(
                    'id' => $id)
            ));
        }

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:edit.html.twig', array(
                'entity'      => $entity,
                'edit_form'   => $editForm->createView(),
                'delete_form' => $deleteForm->createView(),
        ));
    }

    public function deleteAction(Request $request, $id) {
        $form = $this->createDeleteForm($id);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $entity = $em
                    ->getRepository('CidetsiDepartamentoBundle:Departamento')
                    ->find($id);

            if (!$entity) {
                throw $this->createNotFoundException(
                    'Unable to find Departamento entity.');
            }

            $em->remove($entity);
            $em->flush();
        }

        return $this->redirect($this->generateUrl('departamento'));
    }

    private function createDeleteForm($id) {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl(
                'departamento_delete', array('id' => $id)))
            ->setMethod('DELETE')
            ->add('submit', 'submit', array('label' => 'Delete'))
            ->getForm();
    }
}
