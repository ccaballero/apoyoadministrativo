<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class CrudController extends Controller
{
    public function indexAction() {
        $em = $this->getDoctrine()->getManager();
        $entities = $em->getRepository($this->repository)
                       ->findBy(array(), $this->orderBy);
        return $this->render($this->repository . ':index.html.twig', array(
            'entities' => $entities,
        ));
    }

    public function readAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        return $this->render($this->repository . ':read.html.twig', array(
            'entity'      => $entity,
        ));
    }

    protected function createCreateForm($entity) {
        $form = $this->createForm(new $this->form(), $entity, array(
            'action' => $this->generateUrl($this->resource . '_create_post'),
            'method' => 'POST',
        ));
        $form->add('submit', 'submit', array('label' => 'Agregar'));
        return $form;
    }

    protected function createEditForm($entity) {
        $form = $this->createForm(new $this->form(), $entity, array(
            'action' => $this->generateUrl(
                $this->resource . '_update_post', array(
                    'id' => $entity->getId())),
            'method' => 'PUT',
        ));
        $form->add('submit', 'submit', array('label' => 'Editar'));
        return $form;
    }

    protected function createDeleteForm($id) {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl($this->resource . '_delete_post', array(
                'id' => $id)))
            ->setMethod('DELETE')
            ->add('submit', 'submit', array('label' => 'Eliminar'))
            ->getForm();
    }

    public function createGetAction() {
        $entity = new $this->entity();
        $form   = $this->createCreateForm($entity);
        return $this->render($this->repository . ':new.html.twig', array(
            'entity' => $entity,
            'form'   => $form->createView(),
        ));
    }

    public function editGetAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $editForm = $this->createEditForm($entity);
        return $this->render(
            $this->repository . ':edit.html.twig', array(
                'entity'      => $entity,
                'edit_form'   => $editForm->createView(),
        ));
    }

    public function deleteGetAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $deleteForm = $this->createDeleteForm($id);
        return $this->render(
            $this->repository . ':delete.html.twig', array(
                'entity'      => $entity,
                'delete_form' => $deleteForm->createView(),
        ));
    }

    public function createPostAction(Request $request) {
        $entity = new $this->entity();
        $form = $this->createCreateForm($entity);
        $form->handleRequest($request);
        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($entity);
            $em->flush();
            return $this->redirect(
                $this->generateUrl($this->resource . '_show', array(
                    'id' => $entity->getId())
            ));
        }
        return $this->render($this->repository . ':new.html.twig', array(
            'entity' => $entity,
            'form'   => $form->createView(),
        ));
    }

    public function editPostAction(Request $request, $id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $editForm = $this->createEditForm($entity);
        $editForm->handleRequest($request);
        if ($editForm->isValid()) {
            $em->flush();
            return $this->redirect(
                $this->generateUrl($this->resource . '_read', array(
                    'id' => $id)
            ));
        }
        return $this->render($this->repository . ':edit.html.twig', array(
            'entity'      => $entity,
            'edit_form'   => $editForm->createView(),
        ));
    }

    public function deletePostAction(Request $request, $id) {
        $form = $this->createDeleteForm($id);
        $form->handleRequest($request);
        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $entity = $em->getRepository($this->repository)->find($id);
            if (!$entity) {
                throw $this->createNotFoundException('Unable to find entity.');
            }
            $em->remove($entity);
            $em->flush();
        }
        return $this->redirect($this->generateUrl('departamento'));
    }
}
