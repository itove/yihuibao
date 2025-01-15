<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class AboutController extends AbstractController
{
    #[Route('/about', name: 'app_about')]
    public function index(): Response
    {
        return $this->render('about/index.html.twig', [
            'doctors' => [],
            'departments' => [],
        ]);

        // $data = $this->data->getPageContent('about', $request->getLocale());
        // $data['page']['intro'] = '怀抱“经世济民，天下大同”的美好愿景，大同经纪在荆楚大地播下了希望的种子。在精彩的绽放中实现华丽转身，独树一帜，引领风潮。';

        // return $this->render('about/index.html.twig', $data);
    }
}
