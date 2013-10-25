<?php

namespace Cidetsi\DepartmentBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('CidetsiDepartmentBundle:Default:index.html.twig');
    }
}
