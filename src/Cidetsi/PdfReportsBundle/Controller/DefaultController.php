<?php

namespace Cidetsi\PdfReportsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function testAction() {
        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Default:test.pdf.twig');
        $arguments = array(
            'constructorArgs' => array(
                'UTF-8', 'Letter-L', '8', 'Arial',
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
        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Default:seguimiento.pdf.twig');
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
//        return $this->render('CidetsiPdfReportsBundle:Default:nombramiento.pdf.twig');

        $mpdfService = $this->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Default:nombramiento.pdf.twig');
        $arguments = array(
            'constructorArgs' => array(
                'UTF-8', 'Letter', '8', 'Arial',
                22, 22, 15, 22, 0, 0, 'P'),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => null,
            'outputDest' => null,
        );

        $mpdfService->generatePdfResponse($html, $arguments);
    }
}
