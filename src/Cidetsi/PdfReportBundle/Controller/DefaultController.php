<?php

namespace Cidetsi\PdfReportBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function testAction() {
        return $this->render('CidetsiPdfReportBundle:Default:test.pdf.twig');

        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:test.pdf.twig');
        $arguments = array(
            'constructorArgs' => array(
                'UTF-8', 'Letter-L', '8', 'Helvetica',
                20, 10, 10, 10, 30, 140, 'L'),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => null,
            'outputDest' => null,
        );

        $mpdfService->generatePdfResponse($html, $arguments);
    }

    public function seguimientoAction() {
//        return $this->render('CidetsiPdfReportBundle:Default:seguimiento.pdf.twig');

        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:seguimiento.pdf.twig');

        $arguments = array(
            'constructorArgs' => array(
                'UTF-8', 'Letter-L', '8', 'Arial',
                7, 7, 7, 7, 0, 0, 'L'),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => null,
            'outputDest' => null,
        );

        $mpdfService->generatePdfResponse($html, $arguments);
    }

    public function nombramientoAction() {
        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:nombramiento.pdf.twig');
        $arguments = array(
            'constructorArgs' => array(
                'UTF-8', 'Letter', '8', 'Helvetica',
                22, 22, 22, 22, 0, 0, 'P'),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => null,
            'outputDest' => null,
        );

        $mpdfService->generatePdfResponse($html, $arguments);
    }
}
