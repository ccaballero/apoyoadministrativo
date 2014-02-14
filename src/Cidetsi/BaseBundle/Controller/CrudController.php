<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class CrudController extends Controller
{
    public $filterType = '';

    public function indexAction() {
        return $this->render($this->repository . ':index.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entities' => $this->getList(),
        )));
    }

    protected function getList() {
        $em = $this->getDoctrine()->getManager();

        $orderBy = array();
        foreach ($this->orderBy as $key => $criteria) {
            $orderBy[] = 'e.' . $key . ' ' . $criteria;
        }

        switch ($this->filterType) {
            case 'status':
                $query = $em->createQuery(
                    'SELECT e ' .
                    'FROM ' . $this->repository . ' e ' .
                    'WHERE e.status <> :status ' .
                    'ORDER BY ' . implode(',', $orderBy)
                )->setParameter('status', 'disabled');
                break;
            default:
                $query = $em->createQuery(
                    'SELECT e ' .
                    'FROM ' . $this->repository . ' e ' .
                    'ORDER BY ' . implode(',', $orderBy)
                );
                break;
        }

        return $query->getResult();
    }

    protected function getEntity($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository($this->repository)->find($id);
        if (!$entity) {
            throw $this->createNotFoundException('Unable to find entity.');
        }
        if ($entity->getStatus() == 'disabled') {
            throw $this->createNotFoundException('The entity is disabled.');
        }

        return $entity;
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

    public function readAction($id) {
        $entity = $this->getEntity($id);

        return $this->render($this->repository . ':read.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
        )));
    }

    public function updateGetAction($id) {
        $entity = $this->getEntity($id);
        $updateForm = $this->createUpdateForm($entity);

        return $this->render($this->repository . ':update.html.twig',
            array_merge(
                $this->tpl_commons, array(
                    'entity' => $entity,
                    'update_form' => $updateForm->createView(),
        )));
    }

    public function deleteGetAction($id) {
        $entity = $this->getEntity($id);
        $deleteForm = $this->createDeleteForm($id);

        return $this->render(
            $this->repository . ':delete.html.twig',
                array_merge(
                    $this->tpl_commons, array(
                        'entity' => $entity,
                        'delete_form' => $deleteForm->createView(),
        )));
    }

    public function disabledGetAction($id) {
        return $this->statusGetAction($id, 'disabled');
    }

    public function enabledGetAction($id) {
        return $this->statusGetAction($id, 'enabled');
    }

    protected function statusGetAction($id, $task) {
        $entity = $this->getEntity($id);
        $statusForm = $this->createStatusForm($id, $task);

        return $this->render(
            $this->repository . ':status.html.twig',
                array_merge(
                    $this->tpl_commons, array(
                        'entity' => $entity,
                        'task' => $task,
                        'status_form' => $statusForm->createView(),
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
                    'id' => $entity->getIdent())),
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

    protected function createStatusForm($id, $task) {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl(
                $this->resource . '_' . $task . '_post', array(
                    'id' => $id)))
            ->setMethod('POST')
            ->add('submit', 'submit', array('label' => 'Confirmar'))
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
                    'id' => $entity->getIdent())
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
        $entity = $this->getEntity($id);
        $updateForm = $this->createUpdateForm($entity);
        $updateForm->handleRequest($request);

        if ($updateForm->isValid()) {
            $em = $this->getDoctrine()->getManager();
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

    public function enabledPostAction(Request $request, $id) {
        return $this->statusPostAction($request, $id, 'enabled');
    }

    public function disabledPostAction(Request $request, $id) {
        return $this->statusPostAction($request, $id, 'disabled');
    }

    protected function statusPostAction(Request $request, $id, $task) {
        $form = $this->createStatusForm($id, $task);
        $form->handleRequest($request);
        if ($form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $entity = $em->getRepository($this->repository)->find($id);
            if (!$entity) {
                throw $this->createNotFoundException('Unable to find entity.');
            }
            $entity->setStatus($task);
            $em->flush();
            $this->get('session')->getFlashBag()
                ->add('success', 'El recurso fue deshabilitado exitosamente');
        } else {
            $this->get('session')->getFlashBag()
                 ->add('warning', 'El recurso no pudo ser modificado');
        }

        return $this->redirect($this->generateUrl($this->resource));
    }
}

