<?php

namespace Cidetsi\PdfReportBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    protected function factoryTCPDF($o, $lm, $tm, $rm) {
        $pdf = $this->get('white_october.tcpdf')
                    ->create($o, 'mm', 'LETTER', true, 'UTF-8');

        $pdf->setCreator(PDF_CREATOR);
        $pdf->setAuthor('Bushido');
        $pdf->setTitle('TCPDF html test');
        $pdf->setSubject('Bushido');
        $pdf->setKeywords('TCPDF, PDF, TEST');

        $pdf->setAutoPageBreak(true, 13);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        $pdf->setFontSubsetting(true);
        $pdf->setFont('Helvetica', '', 8, '', 'default', true);
        $pdf->setMargins($lm, $tm, $rm, true);

        $pdf->addPage();
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
        $pdf = $this->factoryTCPDF('L', 7, 7, 7);
        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:seguimiento.pdf.twig');

        $pdf->writeHTML($html, true, false, true, false, '');
        $pdf->output('seguimiento.pdf');
    }

    public function nombramientoAction() {
        $pdf = $this->factoryTCPDF('P', 22, 22, 22);
        $html = $this->renderView(
            'CidetsiPdfReportBundle:Default:nombramiento.pdf.twig');

        $pdf->writeHTML($html, true, false, true, false, '');
        $pdf->output('seguimiento.pdf');
    }
}
