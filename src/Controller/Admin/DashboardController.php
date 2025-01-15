<?php

namespace App\Controller\Admin;

use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator;
use EasyCorp\Bundle\EasyAdminBundle\Config\Crud;
use App\Entity\Order;
use App\Entity\Refund;
use App\Entity\Node;
use App\Entity\Region;
use App\Entity\Page;
use App\Entity\Tag;
use App\Entity\User;
use App\Entity\Feedback;
use App\Entity\Comment;
use App\Entity\Fav;
use App\Entity\Language;
use App\Entity\Conf;
use App\Entity\Category;
use App\Entity\Menu;
use Doctrine\Persistence\ManagerRegistry;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;
use EasyCorp\Bundle\EasyAdminBundle\Config\UserMenu;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\UX\Chartjs\Builder\ChartBuilderInterface;
use Symfony\UX\Chartjs\Model\Chart;

class DashboardController extends AbstractDashboardController
{
    private $doctrine;
    private $conf;

    public function __construct(ManagerRegistry $doctrine, private ChartBuilderInterface $chartBuilder)
    {
      $this->doctrine = $doctrine;
      $this->conf = $doctrine->getRepository(Conf::class)->findOneBy([], ['id' => 'ASC']);
    }
    
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        $chart = $this->chartBuilder->createChart(Chart::TYPE_LINE);
        $chart->setData([
            'labels' => ['一月', '二月', '三月', '四月', '五月', '六月', '七月'],
            'datasets' => [
                [
                    'label' => '内容数量',
                    'backgroundColor' => 'rgb(255, 99, 132)',
                    'borderColor' => 'rgb(255, 99, 132)',
                    'data' => [0, 10, 5, 2, 20, 30, 45],
                ],
            ],
        ]);

        $chart->setOptions([
            'scales' => [
                'y' => [
                    'suggestedMin' => 0,
                    'suggestedMax' => 100,
                ],
            ],
        ]);

        return $this->render('dashboard.html.twig', [
            'chart' => $chart,
        ]);
    }

    public function configureDashboard(): Dashboard
    {
        if ($this->conf) {
            $title = $this->conf->getSitename();
        } else {
            $title = 'Sitename';
        }
        return Dashboard::new()
            ->renderContentMaximized()
            // ->renderSidebarMinimized()
            ->setLocales(['en', 'zh_CN'])
            ->setTitle($title);
    }
    
    public function configureCrud(): Crud
    {
        return Crud::new()
            ->showEntityActionsInlined()
            ->setTimezone('Asia/Shanghai')
            ->setDateTimeFormat('yyyy/MM/dd HH:mm')
            ->setDefaultSort(['id' => 'DESC'])
        ;
    }

    public function configureActions(): Actions
    {
        return Actions::new()
            // ->disable('delete')
            ->add('detail', 'edit')
            ->add('index', 'edit')
            ->add('index', 'new')
            ->add('index', 'delete')
            ->add(Crud::PAGE_NEW, Action::SAVE_AND_RETURN)
            ->add(Crud::PAGE_EDIT, Action::SAVE_AND_RETURN)
            ->add(Crud::PAGE_EDIT, Action::SAVE_AND_CONTINUE)
        ;
    }

    public function configureUserMenu(UserInterface $user): UserMenu
    {
        return parent::configureUserMenu($user)
            ->setName($user->getUsername() . ' (' . $user->getName() . ')')
            // ->displayUserName(false)
        ;
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToUrl('Back to Site', 'fas fa-arrow-circle-left', '/');

        $pages = $this->doctrine->getRepository(Page::class)->findBy([], ['weight' => 'ASC', 'id' => 'ASC']);
        
        yield MenuItem::section('Content Management')
            // ->setCssClass('test');
            // ->setBadge('test')
            // ->setPermission('ROLE_SUPER_ADMIN')
        ;
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-chart-pie');
        
        foreach ($pages as $p) {
            if ($_ENV['USE_SUBMENU']) {
                $items = [];
            } else {
                if (count($p->getRegions()) > 0) {
                    yield MenuItem::section($p->getName());
                }
            }

            foreach ($p->getRegions() as $region) {
                $item = MenuItem::linkToCrud($region->getName(), "fas fa-{$region->getIcon()}", Node::class)
                    ->setQueryParameter('region', $region->getId())
                    ->setController(_N::class . $region->getId())
                ;
                if ($_ENV['USE_SUBMENU']) {
                    array_push($items, $item);
                } else {
                    yield $item;
                }
            }

            if ($_ENV['USE_SUBMENU']) {
                yield MenuItem::subMenu($p->getName(), 'fa fa-folder')->setSubItems($items);
            }
        }

        yield MenuItem::section('User Content');
        yield MenuItem::linkToCrud('Comment Management', 'fas fa-message', Comment::class);
        yield MenuItem::linkToCrud('Feedback', 'fas fa-message', Feedback::class);
        yield MenuItem::linkToCrud('User Fav', 'fas fa-message', Fav::class);
        
        yield MenuItem::section('Taxon Management');
        if ($_ENV['HAVE_ORDERS']) {
            yield MenuItem::linkToCrud('Order Management', 'fas fa-book-open', Order::class);
            yield MenuItem::linkToCrud('Refund Records', 'fas fa-book-open', Refund::class);
        }
        yield MenuItem::linkToCrud('Menu Management', 'fas fa-link', Menu::class);
        yield MenuItem::linkToCrud('Tag Management', 'fas fa-tags', Tag::class);
        yield MenuItem::linkToCrud('Category Management', 'fas fa-table-cells-large', Category::class);
        yield MenuItem::section('Region Management');
        yield MenuItem::linkToCrud('Page Management', 'fas fa-cog', Page::class);
        yield MenuItem::linkToCrud('Region Management', 'fas fa-cog', Region::class);
        
        yield MenuItem::section('Settings');
        yield MenuItem::linkToCrud('Change Password', 'fas fa-key', User::class)
            ->setQueryParameter('action', 'chpw')
            ->setAction('edit')
            ->setEntityId($this->getUser()->getId())
            ;
        if ($this->isGranted('ROLE_ADMIN')) {
            yield MenuItem::linkToCrud('User Management', 'fas fa-users', User::class);
            if ($_ENV['IS_MULTILINGUAL'] || ! $this->conf) {
                yield MenuItem::linkToCrud('Settings', 'fas fa-cog', Conf::class);
            } else {
                yield MenuItem::linkToCrud('Settings', 'fas fa-cog', Conf::class)
                    ->setAction('detail')
                    ->setEntityId($this->conf->getId())
                ;
            }
            yield MenuItem::linkToUrl('Changelog', 'fas fa-note-sticky', '/changelog/');
        }
        
        if ($this->isGranted('ROLE_SUPER_ADMIN')) {
            yield MenuItem::section('Super Admin');
            yield MenuItem::linkToCrud('All Nodes', 'fas fa-cog', Node::class);
            if ($_ENV['IS_MULTILINGUAL']) {
                yield MenuItem::linkToCrud('Language', 'fas fa-cog', Language::class);
            }
            // yield MenuItem::linkToExitImpersonation('Stop impersonation', 'fa fa-exit');
            // yield MenuItem::linkToCrud('Conf', 'fas fa-cog', Conf::class);
        }
    }
}
