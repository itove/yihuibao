<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/services')]
class ServiceController extends AbstractController
{
    #[Route('', name: 'app_services')]
    public function index(): Response
    {
        $services = [
            [
                'id' => 1,
                'image' => 'service1.jpg',
                'title' => 'General and Preventive Care',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 2,
                'image' => 'service2.jpg',
                'title' => 'Cosmetic Dentistry',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 3,
                'image' => 'service3.jpg',
                'title' => 'Teeth whitening system',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 4,
                'image' => 'service4.jpg',
                'title' => 'Family Doctor services',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 5,
                'image' => 'service5.jpg',
                'title' => 'Dentures & Denture Repair',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 6,
                'image' => 'service6.jpg',
                'title' => 'Laboratory',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 7,
                'image' => 'service7.jpg',
                'title' => 'Sexual Health',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 8,
                'image' => 'service8.jpg',
                'title' => 'Non - Surgical Hair Replacement',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ],
            [
                'id' => 9,
                'image' => 'service9.jpg',
                'title' => 'Additional Treatments',
                'description' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy ...'
            ]
        ];

        $testimonials = [
            [
                'text' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to.',
                'name' => 'Mariya thomas',
                'designation' => 'Designation'
            ],
            [
                'text' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to.',
                'name' => 'Martin John',
                'designation' => 'Designation'
            ],
            [
                'text' => 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to.',
                'name' => 'Woods Lovins',
                'designation' => 'Designation'
            ]
        ];

        return $this->render('service/index.html.twig', [
            'services' => $services,
            'testimonials' => $testimonials,
            'cta_text' => 'Schedule your appointment today and experience our professional healthcare services.'
        ]);
    }

    #[Route('/{id}', name: 'app_service_details', requirements: ['id' => '\d+'])]
    public function details(int $id): Response
    {
        // Previous details action code remains the same
        $service = [
            'title' => 'Laboratory Services',
            'description' => 'Comprehensive laboratory services including blood work, diagnostics, and testing.',
            'quote' => 'State-of-the-art facilities providing accurate and timely results.',
            'content' => 'Our laboratory offers a wide range of diagnostic services with the latest technology...'
        ];

        $featured_services = [
            [
                'image' => 'service7.jpg',
                'title' => 'Sexual Health'
            ],
            [
                'image' => 'service8.jpg',
                'title' => 'Non - Surgical Hair Replacement'
            ],
            [
                'image' => 'service9.jpg',
                'title' => 'Additional Treatments'
            ]
        ];

        $testimonials = [
            [
                'text' => 'Excellent service and professional staff. The laboratory results were delivered quickly and accurately.',
                'name' => 'Mariya Thomas',
                'designation' => 'Patient'
            ],
            [
                'text' => 'Very impressed with the modern facilities and attention to detail in all procedures.',
                'name' => 'Martin John',
                'designation' => 'Patient'
            ],
            [
                'text' => 'The staff was very helpful in explaining the procedures and making me feel comfortable.',
                'name' => 'Woods Lovins',
                'designation' => 'Patient'
            ]
        ];

        return $this->render('service/details.html.twig', [
            'service' => $service,
            'featured_services' => $featured_services,
            'testimonials' => $testimonials,
        ]);
    }
} 