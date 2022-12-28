<?php

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/PHPClass.php to edit this template
 */

namespace App\Service;

use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Message;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Component\Mime\Address;
use Doctrine\Persistence\ManagerRegistry;

class GestionContact {

    private EntityManagerInterface $em;
    private MailerInterface $mailer;
    private ManagerRegistry $doctrine;
    
    public function __construct(EntityManagerInterface $em, MailerInterface $mailer, ManagerRegistry $doctrine) {
        $this->em = $em;
        $this->mailer = $mailer;
        $this->doctrine = $doctrine;
    }
    
    public function creerMessage(Message $message) {
        $this->em->persist($message);
        $this->em->flush();
    }

    public function envoiMailContact(Message $message) {
        $email = (new  TemplatedEmail())
                ->from($message->getMail())
                ->to(new Address('dylanesculier@gmail.com','Contact Symfony'))
                ->subject('Demande de renseignement')
                ->text('Bonjour')
                ->htmlTemplate('mails/mailcontact.html.twig')
                ->context ([
                    'contact' => $message,
                ]);
        $this->mailer->send($email);
    }
}