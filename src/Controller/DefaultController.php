<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Brand;
use App\Entity\Product;
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
        $products =  $this->getDoctrine()->getRepository(Product::class)->findByDeletedAt('p.name');

        return $this->render('front/home.html.twig', [
            'brands' => $brands,
            'products' => $products
        ]);
    }
}