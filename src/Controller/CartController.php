<?php

namespace App\Controller;

use App\Entity\Item;
use App\Entity\Product;
use App\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class CartController
 * @package App\Controller
 */
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

    /**
     * @Route("/cart/checkout", name="cart.checkout")
     */
    public function checkout(Request $request)
    {
        \Stripe\Stripe::setApiKey('sk_test_XzLnJG2tgMhnzYAdietJqW1f');

        $command = $this->getUser()->getOrdersByStatus(0);

        // Variable POST

        return $this->render('cart/checkout.html.twig', ['command' => $command, "publishable_key" => "pk_test_NEDk9nXXSYacB5siSbRWziMo", 'amount' => $command->totalTTC() * 100 ]);
    }

    /**
     * @Route("/cart/del/{id}", name="cart.checkout.delete")
     */
    public function del(Request $request, Item $item)
    {
        $em = $this->getDoctrine()->getManager();
        $em->remove($item);
        $em->flush();

        return $this->redirectToRoute('cart.checkout');
    }
}
