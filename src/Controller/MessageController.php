<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Message;
use App\Form\MessageType;
use App\Service\GestionContact;
use Symfony\Component\HttpFoundation\Request;

class MessageController extends AbstractController
{
    #[Route('/message', name: 'app_message')]
    public function index(GestionContact $gestionContact, Request $request): Response
    {
        $message = new Message();

        $form = $this->createForm(MessageType::class, $message);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $gestionContact->creerMessage($message);
            $gestionContact->envoiMailContact($message);
            $this->addFlash('success', 'Votre demande a bien été envoyé');
            return $this->redirectToRoute('app_accueil');
        }
        return $this->render('message/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
