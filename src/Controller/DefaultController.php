<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Brand;
use App\Entity\Product;
use App\Form\SearchProductType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    /**
     * @Route("/", name="front_default")
     */
    public function home(Request $request): Response
    {
        $searchForm = $this->createForm(SearchProductType::class, null);
        $searchForm->handleRequest($request);

        if ($searchForm->isSubmitted() && $searchForm->isValid()) {
            $products = $this->getDoctrine()->getRepository(Product::class)->findByArgs($searchForm->getData());
        } else {
            $products = $this->getDoctrine()->getRepository(Product::class)->findByDeletedAt('p.name');
        }

        $brands = $this->getDoctrine()->getRepository(Brand::class)->findByDeletedAt();

        return $this->render('front/home.html.twig', [
            'brands' => $brands,
            'products' => $products,
            'form' => $searchForm->createView()
        ]);
    }

    /**
     * @Route("/{id}/article", name="front_article")
     */
    public function article(Product $product): Response
    {
        return $this->render('front/article.html.twig', [
            'product' => $product
        ]);
    }
}