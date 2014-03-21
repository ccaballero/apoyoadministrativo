<?php

namespace Cidetsi\PdfReportsBundle\Entity;

class CustomPdf {
    /* Posibilities for constructor args:
     *      mode
     *      format
     *      font-size
     *      font
     *      mgl         -> margin left
     *      mgr         -> margin right
     *      mgt         -> margin top
     *      mgb         -> margin bottom
     *      mgh         -> margin header
     *      mgf         -> margin footer
     *      orientation
     */
    public static function getService($controller, $constructorArgs) {
        $mpdfService = $controller->get('tfox.mpdfport');
        $mpdfService->setAddDefaultConstructorArgs(false);

        $mPDF = $mpdfService->getMpdf($constructorArgs);
        return [$mpdfService, $mPDF];
    }
}

