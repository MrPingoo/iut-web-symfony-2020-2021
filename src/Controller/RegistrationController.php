<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\RegistrationFormType;
use App\Form\ResetType;
use App\Form\ResetValidationType;
use App\Repository\UserRepository;
use App\Security\AppAuthenticator;
use App\Service\EmailService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Guard\GuardAuthenticatorHandler;

class RegistrationController extends AbstractController
{
    CONST SENDER = '2a21ae3246-201ee0@inbox.mailtrap.io';

    /**
     * @Route("/register", name="app_register")
     */
    public function register(Request $request, UserPasswordEncoderInterface $passwordEncoder, GuardAuthenticatorHandler $guardHandler, AppAuthenticator $authenticator, MailerInterface $mailer): Response
    {
        $user = new User();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            $user->setPassword(
                $passwordEncoder->encodePassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            );

            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($user);
            $entityManager->flush();
            // do anything else you need here, like send an email

            $email = (new Email())
                ->from(self::SENDER)
                ->to($user->getEmail())
                ->subject('Welcome !')
                ->html(
                    $this->renderView(
                    // templates/emails/registration.html.twig
                        'emails/registration.html.twig',
                        ['user' => $user]
                    )
                )
            ;

            $mailer->send($email);

            return $guardHandler->authenticateUserAndHandleSuccess(
                $user,
                $request,
                $authenticator,
                'main' // firewall name in security.yaml
            );
        }

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }

    /**
     * @Route("/reset", name="app_reset")
     */
    public function reset(Request $request, UserPasswordEncoderInterface $passwordEncoder, GuardAuthenticatorHandler $guardHandler, AppAuthenticator $authenticator, MailerInterface $mailer, UserRepository $userRepository): Response
    {
        $form = $this->createForm(ResetType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user = $userRepository->findOneByEmail($form->getData()['email']);
            if ($user) {
                $entityManager = $this->getDoctrine()->getManager();
                $user->setToken(md5(uniqid()));
                $entityManager->persist($user);
                $entityManager->flush();
                // do anything else you need here, like send an email

                $email = (new Email())
                    ->from(self::SENDER)
                    ->to($user->getEmail())
                    ->subject('Reset !')
                    ->html(
                        $this->renderView(
                        // templates/emails/registration.html.twig
                            'emails/reset.html.twig',
                            ['user' => $user]
                        )
                    )
                ;

                $mailer->send($email);
            }

            return $this->redirectToRoute('front_default');
        }

        return $this->render('registration/reset.html.twig', [
            'form' => $form->createView(),
        ]);
    }


    /**
     * @Route("/reset-validation/{token}", name="app_reset_validation")
     */
    public function resetValidation(Request $request, $token, UserPasswordEncoderInterface $passwordEncoder, GuardAuthenticatorHandler $guardHandler, AppAuthenticator $authenticator, MailerInterface $mailer, UserRepository $userRepository): Response
    {
        $user = $userRepository->findOneByToken($token);
        $form = $this->createForm(ResetValidationType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            $user->setPassword(
                $passwordEncoder->encodePassword(
                    $user,
                    $form->get('password')->getData()
                )
            );

            return $guardHandler->authenticateUserAndHandleSuccess(
                $user,
                $request,
                $authenticator,
                'main' // firewall name in security.yaml
            );
        }

        return $this->render('registration/validation.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
