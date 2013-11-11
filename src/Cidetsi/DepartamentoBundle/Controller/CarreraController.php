<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class CarreraController extends Controller
{
    public function indexAction() {
        $list = $this->getDoctrine()
                     ->getRepository('CidetsiDepartamentoBundle:Carrera')
                     ->findBy(array(), array('name' => 'asc'));

        return $this->render(
            'CidetsiDepartamentoBundle:Carrera:index.html.twig', array(
                'list' => $list
        ));
    }
}
