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

    public function pdfAction() {
        $html = $this->renderView('CidetsiBaseBundle:Default:test.pdf.twig');
        $pdf = $this->get('white_october.tcpdf')->create();

//        $pdf = new TCPDF($orientation, 'mm', 'LETTER', true, 'UTF-8');
        $pdf->setMargins(10, 20, 10, true);
        $pdf->setAutoPageBreak(true, 13);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        $pdf->setFont('times', '', '11');
        $pdf->addPage();

        $pdf->writeHTML($html, true, false, true, false, '');
        $pdf->output('asdf.pdf');
    }
}
