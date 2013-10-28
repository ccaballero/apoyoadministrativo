<?php

namespace Cidetsi\DepartamentoBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('CidetsiDepartamentoBundle:Default:index.html.twig');
    }
}
