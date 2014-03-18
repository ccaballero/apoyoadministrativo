<?php

namespace Cidetsi\PdfReportsBundle\Entity;

class CustomPdf {
    public static function getService($controller) {
        $mpdfService = $controller->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $mPDF = $mpdfService->getMpdf();
        return [$mpdfService, $mPDF];
    }

    /* Posibilities:
     *      format
     *      mgl
     *      mgr
     *      mgt
     *      mgb
     *      mgh
     *      mgf
     *      orientation
     *      title
     *      mpdf
     */
    public static function getArgs($args) {
        return array(
//            'constructorArgs' => array('UTF-8', 'Letter-L', '1', 'Arial', 10, 10, 10, 10, 10, 10, 'L'),
            'constructorArgs' => array(),
            'writeHtmlMode' => null,
            'writeHtmlInitialise' => null,
            'writeHtmlClose' => null,
            'outputFilename' => 'Test',
            'outputDest' => 'I',
            'mpdf' => $args['mpdf'],
        );
    }
}

