<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use Knp\Bundle\SnappyBundle\Snappy\Response\PdfResponse;
use Knp\Snappy\Pdf;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class InvoiceController extends AbstractController
{
    /**
     * @Route("/download/", name="facture_download", methods={"GET"})
     */
    public function download(Pdf $pdf, Request $request): Response
    {

        $html = $this->renderView('invoice/download.html.twig', array(
            'facture'  => ['amount' => 1500, 'name' => 'Invoice 123456']
        ));

        return new PdfResponse($pdf->getOutputFromHtml($html), 'invoice.pdf');
    }
}