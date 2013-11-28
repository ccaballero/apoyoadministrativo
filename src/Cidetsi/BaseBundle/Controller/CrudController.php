<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class CrudController extends Controller
{
    public function indexAction() {
        $em = $this->getDoctrine()->getManager();
//        $entities = $em->getRepository($this->repository)
//                       ->findBy(
//                            array('status' => 'enabled'),
//                            $this->orderBy);

        $orderBy = array();
        foreach ($this->orderBy as $key => $criteria) {
            $orderBy[] = 'e.' . $key . ' ' . $criteria;
        }
        
        $query = $em->createQuery(
            'SELECT e ' .
            'FROM ' . $this->repository . ' e ' .
            'WHERE e.status <> :status ' .
            'ORDER BY ' . implode(',', $orderBy)
        )->setParameter('status', 'disabled');
        $entities = $query->getResult();
        
        return $this->render($this->repository . ':index.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entities' => $entities,
        )));
    }

    public function readAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        if ($entity->getStatus() == 'disabled') {
            throw $this->createNotFoundException('The entity is disabled.');
        }

        return $this->render($this->repository . ':read.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
        )));
    }

    public function createGetAction() {
        $entity = new $this->entity();
        $form = $this->createCreateForm($entity);

        return $this->render($this->repository . ':create.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    public function updateGetAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $updateForm = $this->createUpdateForm($entity);

        return $this->render($this->repository . ':update.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'update_form' => $updateForm->createView(),
        )));
    }

    public function deleteGetAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $deleteForm = $this->createDeleteForm($id);

        return $this->render(
            $this->repository . ':delete.html.twig',
                array_merge(
                    $this->tpl_commons, array(
                        'entity' => $entity,
                        'delete_form' => $deleteForm->createView(),
        )));
    }

    protected function createCreateForm($entity) {
        $form = $this->createForm(new $this->form(), $entity, array(
            'action' => $this->generateUrl($this->resource . '_create_post'),
            'method' => 'POST',
        ));
        $form->add('submit', 'submit', array('label' => 'Agregar'));

        return $form;
    }

    protected function createUpdateForm($entity) {
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
            ->setAction($this->generateUrl(
                $this->resource . '_delete_post', array(
                    'id' => $id)))
            ->setMethod('DELETE')
            ->add('submit', 'submit', array('label' => 'Eliminar'))
            ->getForm();
    }

    public function createPostAction(Request $request) {
        $entity = new $this->entity();
        $form = $this->createCreateForm($entity);
        $form->handleRequest($request);
        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($entity);
            $em->flush();

            $this->get('session')->getFlashBag()
                 ->add('success', 'El recurso fue creado exitosamente');
            return $this->redirect(
                $this->generateUrl($this->resource . '_read', array(
                    'id' => $entity->getId())
            ));
        }

        return $this->render($this->repository . ':create.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'form' => $form->createView(),
        )));
    }

    public function updatePostAction(Request $request, $id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        $updateForm = $this->createUpdateForm($entity);
        $updateForm->handleRequest($request);

        if ($updateForm->isValid()) {
            $em->flush();
            $this->get('session')->getFlashBag()
                 ->add('success', 'El recurso fue editado exitosamente');

            return $this->redirect(
                $this->generateUrl($this->resource . '_read', array(
                    'id' => $id)
            ));
        }

        return $this->render($this->repository . ':update.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'update_form' => $updateForm->createView(),
        )));
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
            if ($entity->isEmpty()) {
                $em->remove($entity);
            } else {
                $entity->setStatus('disabled');
            }
            $em->flush();
            $this->get('session')->getFlashBag()
                 ->add('success', 'El recurso fue eliminado exitosamente');
        } else {
            $this->get('session')->getFlashBag()
                 ->add('warning', 'El recurso no pudo ser eliminado');
        }

        return $this->redirect($this->generateUrl($this->resource));
    }
}
