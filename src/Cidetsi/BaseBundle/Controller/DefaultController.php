<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction() {
        return $this->render('CidetsiBaseBundle:Default:index.html.twig');
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
