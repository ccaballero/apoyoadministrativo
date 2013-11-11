<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction() {
        $list = $this->getDoctrine()
                     ->getRepository('CidetsiDepartamentoBundle:Departamento')
                     ->findAll();

        return $this->render(
            'CidetsiDepartamentoBundle:Default:index.html.twig', array(
                'list' => $list
        ));
    }
}
