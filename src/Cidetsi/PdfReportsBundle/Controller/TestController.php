<?php

namespace Cidetsi\PdfReportsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Cidetsi\PdfReportsBundle\Entity\CustomPdf;

class TestController extends Controller
{
    public function testAction() {
        $args = array('utf-8', 'Letter', 0, '', 30, 20, 45, 30, 20, 20);
        list($service, $mpdf) = CustomPdf::getService($this, $args);

        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Test:test.pdf.twig');
        $header = $this->renderView(
            'CidetsiPdfReportsBundle:Test:header.pdf.twig');
        $footer = $this->renderView(
            'CidetsiPdfReportsBundle:Test:footer.pdf.twig');

        $mpdf->setHTMLHeader($header);
        $mpdf->setHTMLFooter($footer);
        $service->generatePdfResponse($html, array(
            'outputFilename' => 'página_de_evaluación.pdf',
            'outputDest' => 'I',
            'mpdf' => $mpdf,
        ));
    }
}

