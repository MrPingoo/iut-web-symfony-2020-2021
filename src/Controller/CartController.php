<?php

namespace App\Controller;

use App\Entity\Item;
use App\Entity\Product;
use App\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class CartController extends AbstractController
{
    /**
     * @Route("/cart/add", name="cart.add")
     */
    public function add(Request $request)
    {
        $data = $request->request->all();

        /** @var User $user */
        $user = $this->getUser();
        $command = $user->getOrdersByStatus(0);

        $item = new Item();
        $item->setQuantity($data['quantity']);
        $item->setProduct($this->getDoctrine()->getRepository(Product::class)->findOneById($data['id']));
        $item->setCommand($command);

        $em = $this->getDoctrine()->getManager();
        $em->persist($item);
        $em->flush();

        return JsonResponse::create(['data' => true]);
    }

    /**
     * @Route("/cart/show", name="cart.show")
     */
    public function show(Request $request)
    {
        $command = $this->getUser()->getOrdersByStatus(0);

        return $this->render('cart/show.html.twig', ['command' => $command]);
    }
}
