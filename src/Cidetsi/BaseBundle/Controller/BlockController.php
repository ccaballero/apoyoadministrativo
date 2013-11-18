<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class BlockController extends Controller
{
    public function menuAction() {
        return $this->render('CidetsiBaseBundle:Block:menu.html.twig');
    }

    public function toolbarAction() {
        return $this->render('CidetsiBaseBundle:Block:toolbar.html.twig');
    }

    public function footerAction() {
        return $this->render('CidetsiBaseBundle:Block:footer.html.twig');
    }
}
