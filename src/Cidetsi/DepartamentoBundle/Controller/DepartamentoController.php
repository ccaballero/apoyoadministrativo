<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DepartamentoController extends Controller
{
    public function indexAction() {
        $list = $this->getDoctrine()
                     ->getRepository('CidetsiDepartamentoBundle:Departamento')
                     ->findBy(array(), array('name' => 'asc'));

        return $this->render(
            'CidetsiDepartamentoBundle:Departamento:index.html.twig', array(
                'list' => $list
        ));
    }
}
