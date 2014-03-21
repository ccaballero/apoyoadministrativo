<?php

namespace Cidetsi\PdfReportsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    protected function getService() {
        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);
        return $mpdfService;
    }

    protected function getArguments($args, $mpdf) {
        $format = $args[0];
        $mgl = intval($args[1]);
        $mgr = intval($args[2]);
        $mgt = intval($args[3]);
        $mgb = intval($args[4]);
        $mgh = intval($args[5]);
        $mgf = intval($args[6]);
        $orientation = $args[7];
        $title = $args[8];

        return array(
            'constructorArgs' => array(
                'UTF-8', $format, '8', 'Arial',
                $mgl, $mgr, $mgt, $mgb, $mgh, $mgf, $orientation),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => $title,
            'outputDest' => 'I',
            'mpdf' => $mpdf,
        );
    }

    public function seguimientoAction() {
        $pdf = $this->getService();
        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Default:seguimiento.pdf.twig');
        $args = $this->getArguments(
            array('Letter-L', 7, 7, 7, 7, 0, 0, 'L'));
        $pdf->generatePdfResponse($html, $args);
    }

    public function nombramientoAction() {
        $pdf = $this->getService();
        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Default:nombramiento.pdf.twig');
        $args = $this->getArguments(
            array('Letter', 22, 22, 15, 22, 0, 0, 'P'));
        $pdf->generatePdfResponse($html, $args);
    }
}

