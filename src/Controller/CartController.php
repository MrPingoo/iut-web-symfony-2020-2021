<?php

namespace App\Controller;

use App\Entity\Item;
use App\Entity\Order;
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

        if (!$command) {
            $command = new Order();
            $command->setCratedAt(new \DateTime());
            $command->setUpdatedAt(new \DateTime());
            $command->setUser($user);
            $command->setStatus(0);

            $em = $this->getDoctrine()->getManager();
            $em->persist($command);
            $em->flush();
        }

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
        // Get Entity Manager
        $em = $this->getDoctrine()->getManager();
        $user = $this->getUser();

        // Set Stripe Api Key
        \Stripe\Stripe::setApiKey('sk_test_XzLnJG2tgMhnzYAdietJqW1f');

        // Get Cart
        $command = $this->getUser()->getOrdersByStatus(0);

        // Get Post vars
        $data = $request->request->all();

        // Get Amount
        $amount = $command->totalTTC() * 100;

        // Check Stripe validation
        if (isset($data['stripeToken']) && isset($data['stripeEmail'])) {

            $customer = \Stripe\Customer::create([
                'email' => $data['stripeEmail'],
                'source'  => $data['stripeToken'],
            ]);

            $user->setStripeCustomerId($customer->id);
            $em->persist($user);
            $em->flush();

            $charge = \Stripe\Charge::create([
                'customer' => $customer->id,
                'amount'   => $amount,
                'currency' => 'eur',
            ]);

            if ($charge->status == 'succeeded') {
                $command->setStatus(1);

                $em->persist($command);
                $em->flush();

                return $this->redirectToRoute('cart.thanks');
            } else {
                return $this->redirectToRoute('cart.checkout');
            }
        }

        return $this->render('cart/checkout.html.twig', ['command' => $command, "publishable_key" => "pk_test_NEDk9nXXSYacB5siSbRWziMo", 'amount' => $amount ]);
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

    /**
     * @Route("/cart/thanks/", name="cart.thanks")
     */
    public function thanks(Request $request)
    {

        return $this->render('cart/thanks.html.twig');
    }

}
