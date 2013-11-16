<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class CarreraController extends Controller
{
    public function indexAction() {
        $em = $this->getDoctrine()->getManager();
        $entities = $em->getRepository('CidetsiDepartamentoBundle:Carrera')
                       ->findBy(array(), array('name' => 'asc'));

        return $this->render(
            'CidetsiDepartamentoBundle:Carrera:index.html.twig', array(
                'entities' => $entities,
        ));
    }

    public function showAction($id) {
        $em = $this->getDoctrine()->getManager();
        $entity = $em->getRepository('CidetsiDepartamentoBundle:Carrera')
                     ->find($id);

        if (!$entity) {
            throw $this->createNotFoundException(
                'Unable to find Carrera entity.');
        }

        $deleteForm = $this->createDeleteForm($id);

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:show.html.twig', array(
                'entity'      => $entity,
                'delete_form' => $deleteForm->createView(),
        ));
    }
}
