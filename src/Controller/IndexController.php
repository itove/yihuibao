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
        $data['services'] = $this->data->findNodesByRegionLabel('services');
        $data['staffs'] = $this->data->findNodesByRegionLabel('staffs');

        dump($data);
        
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

    #[Route('/about', name: 'app_about')]
    public function about(Request $request): Response
    {
        $data = $this->data->getPageContent('about', $request->getLocale());

        // $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';

        return $this->render('about/index.html.twig', $data);
    }

    #[Route('/contact', name: 'app_contact')]
    public function contact(Request $request): Response
    {
        $data = $this->data->getPageContent('contact', $request->getLocale());
        // $data['page']['label'] = 'Contact Us';
        // $data['page']['intro'] = '大同已根植湖并走向全国：下辖28家机构，其中湖北省内分公司18家，省外分公司6家，省内营业部 4 家。';

        return $this->render('contact/index.html.twig', $data);
    }

    #[Route('/contact/submit', name: 'app_contact_submit', methods: ['POST'])]
    public function contact_submit(Request $request): Response
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
