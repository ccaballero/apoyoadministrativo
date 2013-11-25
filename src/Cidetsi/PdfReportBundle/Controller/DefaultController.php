<?php

namespace Cidetsi\PdfReportBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    protected function factoryTCPDF($orientation) {
        $pdf = $this->get('white_october.tcpdf')
                    ->create($orientation, 'mm', 'LETTER', true, 'UTF-8');

        // set document information
        $pdf->setCreator(PDF_CREATOR);
        $pdf->setAuthor('Bushido');
        $pdf->setTitle('TCPDF html test');
        $pdf->setSubject('Bushido');
        $pdf->setKeywords('TCPDF, PDF, TEST');

        $pdf->setAutoPageBreak(true, 13);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

//        $pdf->setFont('times', '', '11');
//        $pdf->addPage();

        return $pdf;
    }

    public function testAction() {
        $pdf = $this->factoryTCPDF('P');
        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:test.pdf.twig');

        $pdf->writeHTML($html, true, false, true, false, '');
        $pdf->output('pdftest.pdf');
    }

    public function seguimientoAction() {
        $pdf = $this->factoryTCPDF('L');

        $pdf->setFontSubsetting(true);
        $pdf->setFont('Helvetica', '', 8, '', 'default', true);

        $pdf->setMargins(7, 7, 7, true);
        $pdf->addPage();

        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:seguimiento.pdf.twig');

//        return $this->render('CidetsiPdfReportBundle:Default:seguimiento.pdf.twig');
        
        $pdf->writeHTML($html, true, false, true, false, '');
        $pdf->output('seguimiento.pdf');
    }
}
