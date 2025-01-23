<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class DoctorController extends AbstractController
{
    #[Route('/doctors', name: 'app_doctors')]
    public function index(): Response
    {
        // In a real application, you would fetch this from a database
        $doctors = [
            [
                'id' => 1,
                'image' => 'dc1.jpg',
                'name' => 'Dr. Indhulekha Mari',
                'department' => 'Oral Health',
                'facebook' => '#',
                'twitter' => '#',
                'googleplus' => '#'
            ],
            // Add more doctors here...
        ];

        return $this->render('doctor/index.html.twig', [
            'doctors' => $doctors,
            'next_page' => 2 // For pagination
        ]);
    }

    #[Route('/doctor/details/{id}', name: 'app_doctor_details')]
    public function details(int $id = null): Response
    {
        // In a real application, you would fetch the doctor from the database
        $doctor = [
            'name' => 'Dr. John Doe',
            'qualifications' => 'MBBS, MD',
            'department' => 'Cardiology',
            'description' => 'Lorem ipsum...',
            'schedule' => [
                'Monday' => '08:00-18:30',
                'Tuesday' => '08:00-18:30',
                'Wednesday' => '08:00-18:30'
            ],
            'schedule_extra' => [
                'Thursday' => '08:00-18:30',
                'Friday' => '08:00-18:30',
                'Sunday' => 'Not available'
            ]
        ];

        return $this->render('doctor/details.html.twig', [
            'doctor' => $doctor,
            'related_doctors' => [] // Fetch related doctors from database
        ]);
    }
} 
