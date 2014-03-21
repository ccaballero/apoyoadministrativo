<?php

namespace Cidetsi\PdfReportsBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Cidetsi\PdfReportsBundle\Entity\CustomPdf;

class MateriasController extends Controller
{
    public function listAction($id) {
        // Fetching
        $departamento = $this->getDoctrine()->getManager()
            ->getRepository('CidetsiDepartamentosBundle:Departamento')
            ->find($id);
        $materias = $departamento->listMaterias();

        // Printing
        $args = array('utf-8', 'Letter', 0, '', 30, 20, 40, 30, 20, 20);
        list($service, $mpdf) = CustomPdf::getService($this, $args);

        $html = $this->renderView(
            'CidetsiPdfReportsBundle:Materias:list.pdf.twig', array(
                'materias' => $materias,
        ));
        $header = $this->renderView(
            'CidetsiPdfReportsBundle:Materias:header.pdf.twig', array(
                'departamento' => $departamento,
        ));
        $footer = $this->renderView(
            'CidetsiPdfReportsBundle:Test:footer.pdf.twig');

        $mpdf->setHTMLHeader($header);
        $mpdf->setHTMLFooter($footer);
        $service->generatePdfResponse($html, array(
            'outputFilename' => 'lista-materias.pdf',
            'outputDest' => 'I',
            'mpdf' => $mpdf,
        ));
    }
}

