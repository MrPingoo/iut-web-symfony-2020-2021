<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Brand;
use App\Entity\Order;
use App\Entity\Product;
use App\Entity\User;
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

    /**
     * @Route("/{id}/add-to-cart", name="front_add_to_cart")
     */
    public function addToCart(Product $product)
    {
        /** @var User $user */
        $user = $this->getUser();
        $command = $user->getOrdersByStatus(0);

        if ($command) {

            // ajouter l'item au panier
        } else {
            $command = new Order();
            $command->setCratedAt(new \DateTime());
            $command->setUpdatedAt(new \DateTime());
            $command->setUser($user);
            $command->setStatus(0);

            $em = $this->getDoctrine()->getManager();
            $em->persist($command);
            $em->flush();

            // ajouter l'item au panier
        }

        return $this->redirectToRoute('front_default');
    }
}