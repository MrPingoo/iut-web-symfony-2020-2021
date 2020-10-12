<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Brand;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    /**
     * @Route("/", name="front_default")
     */
    public function home(): Response
    {
        $brands = $this->getDoctrine()->getRepository(Brand::class)->findByDeletedAt();

        return $this->render('front/home.html.twig', [
            'brands' => $brands
        ]);
    }
}