<?php

namespace Cidetsi\PdfReportsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Cidetsi\PdfReportsBundle\Entity\CustomPdf;

class TestController extends Controller
{
    public function testAction() {
        list($service, $mpdf) = CustomPdf::getService($this);
        $args = CustomPdf::getArgs(array('mpdf' => $mpdf));
        $html = $this->renderView('CidetsiPdfReportsBundle:Test:test.pdf.twig');

        $mpdf->setDefaultFontSize();

        $service->generatePdfResponse($html, $args);
    }
}

