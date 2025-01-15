<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Contracts\Translation\TranslatorInterface;
use App\Service\Data;

class IndexController extends AbstractController
{
    private $data;
    private $translator;
    
    public function __construct(TranslatorInterface $translator, Data $data)
    {
        $this->data = $data;
        $this->translator = $translator;
    }
    
    #[Route('/', name: 'app_home')]
    public function index(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        $data['site_name'] = 'test';
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_doctors')]
    public function index1(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_doctor_details')]
    public function index2(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_service_details')]
    public function index3(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_appointment')]
    public function index4(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_departments')]
    public function index5(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_blog')]
    public function index6(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }

    #[Route('/', name: 'app_newsletter_subscribe')]
    public function index7(Request $request): Response
    {
        $data = $this->data->getPageContent('home', $request->getLocale());

        $data['news'] = $this->data->findNodesByRegionLabel('news');
        
        return $this->render('home/index.html.twig', $data);
    }
}
