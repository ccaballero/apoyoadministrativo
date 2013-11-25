<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction() {
        $items = array(
            'departamento' => array(
                'label' => 'Departamentos',
                'description' =>
                    'Lista de los diferentes departamentos en la FCyT',
            ),
            'carrera' => array(
                'label' => 'Carreras',
                'description' =>
                    'Lista de las diferentes carreras que comprenden la FCyT',
            ),
        );

        return $this->render('CidetsiBaseBundle:Default:index.html.twig', array(
            'items' => $items,
        ));
    }

    public function menuAction() {
        return $this->render('CidetsiBaseBundle:Default:menu.html.twig');
    }

    public function toolbarAction() {
        return $this->render('CidetsiBaseBundle:Default:toolbar.html.twig');
    }

    public function footerAction() {
        return $this->render('CidetsiBaseBundle:Default:footer.html.twig');
    }
}
