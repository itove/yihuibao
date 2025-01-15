<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ContactController extends AbstractController
{
    #[Route('/contact', name: 'app_contact')]
    public function index(): Response
    {
        return $this->render('contact/index.html.twig', [
            'contact' => [
                'address' => 'Medical street, Indiranagr, Royal building, 1536',
                'email' => 'info@medical.com',
                'phone' => '+91 8564 2256 555',
            ],
            'map' => [
                'lat' => 23.0739208,
                'lng' => 72.55036849999999,
                'address' => 'Our map Address'
            ],
            // 'google_maps_api_key' => $this->getParameter('google_maps_api_key'),
            'google_maps_api_key' => '123',
        ]);

        // $data = $this->data->getPageContent('contact', $request->getLocale());
        // $data['page']['label'] = 'Contact Us';
        // $data['page']['intro'] = '大同已根植湖并走向全国：下辖28家机构，其中湖北省内分公司18家，省外分公司6家，省内营业部 4 家。';

        // return $this->render('contact.html.twig', $data);
    }

    #[Route('/contact/submit', name: 'app_contact_submit', methods: ['POST'])]
    public function submit(Request $request): Response
    {
        // Handle form submission
        $data = $request->request->all();
        
        // Add your contact form processing logic here
        // For example, send email, save to database, etc.
        
        // Redirect back with success message
        $this->addFlash('success', 'Thank you for your message. We will contact you soon!');
        
        return $this->redirectToRoute('app_contact');
    }
} 
