<?php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Brand;
use App\Entity\Item;
use App\Entity\Order;
use App\Entity\Product;
use App\Entity\User;
use App\Form\BrandType;
use App\Form\ProfilType;
use App\Form\SearchProductType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Guard\GuardAuthenticatorHandler;

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
        // 0 = panier
        // 1 = payé
        // 2 = livré

        /** @var User $user */
        $user = $this->getUser();
        $command = $user->getOrdersByStatus(0);

        if ($command) {
            $item = new Item();
            $item->setCommand($command);
            $item->setProduct($product);
            $item->setQuantity(1);

            $em = $this->getDoctrine()->getManager();
            $em->persist($item);
            $em->flush();
        } else {
            $command = new Order();
            $command->setCratedAt(new \DateTime());
            $command->setUpdatedAt(new \DateTime());
            $command->setUser($user);
            $command->setStatus(0);

            $em = $this->getDoctrine()->getManager();
            $em->persist($command);
            $em->flush();

            $item = new Item();
            $item->setCommand($command);
            $item->setProduct($product);
            $item->setQuantity(1);

            $em = $this->getDoctrine()->getManager();
            $em->persist($item);
            $em->flush();
        }

        return $this->redirectToRoute('front_default');
    }


    /**
     * @Route("/commands", name="front_commands")
     */
    public function commands(): Response
    {
        return $this->render('front/commands.html.twig');
    }


    /**
     * @Route("/edit/profil", name="front_edit_profil", methods={"GET","POST"})
     */
    public function editProfil(Request $request, UserPasswordEncoderInterface $passwordEncoder, GuardAuthenticatorHandler $guardHandler): Response
    {
        $user = $this->getUser();

        $form = $this->createForm(ProfilType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            if ($form->get('plainPassword')->getData()) {
                // encode the plain password
                $user->setPassword(
                    $passwordEncoder->encodePassword(
                        $user,
                        $form->get('plainPassword')->getData()
                    )
                );
            }

            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('front_default');
        }

        return $this->render('front/profil.html.twig', [
            'user' => $user,
            'form' => $form->createView(),
        ]);
    }
}