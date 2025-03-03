<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @author Al Zee <z@alz.ee>
 * @version
 * @todo
 */

namespace App\Service;

use Doctrine\Persistence\ManagerRegistry;
use App\Entity\Conf;
use App\Entity\Node;
use App\Entity\Comment;
use App\Entity\User;
use App\Entity\Tag;
use App\Entity\Region;
use App\Entity\Page;
use App\Entity\Language;
use App\Entity\Menu;
use App\Entity\Order;
use App\Entity\Up;
use App\Entity\Down;
use App\Entity\Rate;
use App\Entity\Feedback;

class Data
{
    private $doctrine;
    
    public function __construct(ManagerRegistry $doctrine)
    {
        $this->doctrine = $doctrine;
    }
    
    public function getEntityManager()
    {
        return $this->doctrine->getManager();
    }
    
    static function GetProperties($entity)
    {
        $reflect = new \ReflectionClass($entity);
        $props   = $reflect->getProperties();
        $arr = [];
        $no_need = ['title', 'latitude', 'longitude', 'comments', 'deleted', 'ups', 'downs', 'favs', 'likes', 'parent', 'children', 'rates', 'plan', 'published'];
        if (!$_ENV['IS_MULTILINGUAL']) {
            array_push($no_need, 'language');
        }

        foreach ($props as $prop) {
            foreach ($prop->getAttributes() as $attrib) {
                // only ORM fields
                if (str_contains($attrib->getName(), 'Doctrine\ORM\Mapping')) {
                    $prop_name = $prop->getName();

                    // Insert space before Capital letters;
                    $name = preg_replace('/(\w+)([A-Z])/U', '\\1 \\2', $prop_name);
                    $name = ucfirst($name);
                    if (!in_array($prop_name, $no_need)) {
                        $arr[$name] = $prop_name;
                    }
                    break;
                }
            }
        }
        
        $arr['Coord'] = 'coord';
        
        return $arr;
    }
    
    public function getPage(string $label)
    {
        return $this->doctrine->getRepository(Page::class)->findOneBy(['label' => $label]);
    }
    
    public function getRegionByLabel(string $label)
    {
        return $this->doctrine->getRepository(Region::class)->findOneBy(['label' => $label]);
    }

    public function getRegion(int $id)
    {
        return $this->doctrine->getRepository(Region::class)->find($id);
    }
    
    public function getNode(int $id)
    {
        return $this->doctrine->getRepository(Node::class)->find($id);
    }

    public function formatOrder(Order $order)
    {
        $data = [
            'id' => $order->getId(),
            'sn' => $order->getSn(),
            'node' => $order->getNode()->getId(),
            'consumer' => $order->getConsumer()->getId(),
            'quantity' => $order->getQuantity(),
            'price' => $order->getPrice(),
            'amount' => $order->getAmount(),
            'createdAt' => $order->getCreatedAt(),
            'paidAt' => $order->getPaidAt(),
            'usedAt' => $order->getUsedAt(),
            'cancelledAt' => $order->getCancelledAt(),
            'refundedAt' => $order->getRefundedAt(),
            'status' => $order->getStatus(),
            'node' => self::formatNode($order->getNode()),
        ];

        return $data;
    }

    public function formatUser(User $u)
    {
        $data = [
            'id' => $u->getId(),
            'username' => $u->getUsername(),
            'roles' => $u->getRoles(),
            'name' => $u->getName(),
            'phone' => $u->getPhone(),
            'avatar' => $u->getAvatar(),
        ];

        return $data;
    }

    public function formatComment(Comment $c)
    {
        $data = [
            'id' => $c->getId(),
            'author' => self::formatUser($c->getAuthor()),
            'body' => $c->getBody(),
            'createdAt' => $c->getCreatedAt(),
            // 'up' => $c->getUp(),
            'ups' => $c->getUps(),
            // 'down' => $c->getDown(),
            'downs' => $c->getDowns(),
        ];

        $data['ups'] = [];
        foreach($c->getUps() as $up){
            array_push($data['ups'], $up->getU()->getId());
        }
        $data['downs'] = [];
        foreach($c->getDowns() as $down){
            array_push($data['downs'], $down->getU()->getId());
        }

        return $data;
    }

    public function formatRate(Rate $r)
    {
        $data = [
            'id' => $r->getId(),
            'user' => self::formatUser($r->getU()),
            // 'node' => [],
            'rate' => $r->getRate(),
            'createdAt' => $r->getCreatedAt(),
        ];

        return $data;
    }

    public function formatFeedback(Feedback $f)
    {
        $data = [
            'id' => $f->getId(),
            'user' => self::formatUser($f->getU()),
            'createdAt' => $f->getCreatedAt(),
            'status' => $f->getStatus(),
            'title' => $f->getTitle(),
            'body' => $f->getBody(),
        ];

        return $data;
    }

    public function formatNode(Node $n)
    {
        $conf = $this->findConfByLocale(null);
        $tags = [];
        foreach ($n->getTags() as $t) {
            array_push($tags, $t->getName());
        }
        $data = [
            'id' => $n->getId(),
            'title' => $n->getTitle(),
            'summary' => $n->getSummary(),
            'tags' => $tags,
            'body' => $n->getBody(),
            'image' => $n->getImage(),
            'audio' => $n->getAudio(),
            'qr' => $n->getQr(),
            'latitude' => $n->getLatitude(),
            'longitude' => $n->getLongitude(),
            'address' => $n->getAddress() ? $n->getAddress() : $conf->getAddress(),
            'phone' => $n->getPhone() ? $n->getPhone() : $conf->getPhone(),
            'price' => $n->getPrice(),
            'createdAt' => $n->getCreatedAt(),
            'author' => [ 'name' => $n->getAuthor()->getName(), 'avatar' => $n->getAuthor()->getAvatar()],
            'marker' => $n->getMarker(),
            'startAt' => $n->getStartAt(),
            'endAt' => $n->getEndAt(),
            'note' => $n->getNote(),
            // 'favs' => count($n->getFavs()),
        ];

        $data['likes'] = [];
        foreach($n->getLikes() as $i){
            array_push($data['likes'], $i->getU()->getId());
        }

        $data['ups'] = [];
        foreach($n->getUps() as $i){
            array_push($data['ups'], $i->getU()->getId());
        }

        $data['downs'] = [];
        foreach($n->getDowns() as $i){
            array_push($data['downs'], $i->getU()->getId());
        }
        
        $data['comments'] = [];
        foreach($n->getComments() as $c){
            array_push($data['comments'], self::formatComment($c));
        }
        
        $data['favs'] = [];
        foreach($n->getFavs() as $f) {
            array_push($data['favs'], $f->getU()->getId());
        }

        $data['images'] = [];
        foreach($n->getImages() as $i) {
            array_push($data['images'], $i->getImage());
        }

        $data['rates'] = [
            'rate' => 0,
            'users' => [],
        ];

        if(count($n->getRates()) > 0) {
            $v = 0;
            foreach($n->getRates() as $r) {
                $v = $v + $r->getRate();
                array_push($data['rates']['users'], $r->getU()->getId());
            }
            $data['rates']['rate'] = round($v / count($n->getRates()), 1);
        }

        if (!empty($n->getRegions())) {
            $data['region'] = [
                'id' => $n->getRegions()[0]->getId(),
                'name' => $n->getRegions()[0]->getName(),
                'label' => $n->getRegions()[0]->getLabel(),
                'marker' => $n->getRegions()[0]->getMarker(),
            ];
        }
        
        $children = [];
        foreach ($n->getChildren() as $k => $v) {
            $children[$k]['title'] = $v->getTitle();
            $children[$k]['summary'] = $v->getSummary();
            $children[$k]['images'] = $v->getImages();
            $tags = [];
            foreach ($v->getTags() as $t) {
                array_push($tags, $t->getName());
            }
            $children[$k]['tags'] = $tags;

            $images = [];
            foreach ($v->getImages() as $i) {
                array_push($images, $i->getImage());
            }
            $children[$k]['images'] = $images;
        }
        $data['children'] = $children;
        
        return $data;
    }
    
    public function getPrev(Node $node)
    {
        return $this->doctrine->getRepository(Node::class)->findPrev($node);
    }

    public function getNext(Node $node)
    {
        return $this->doctrine->getRepository(Node::class)->findNext($node);
    }
    
    public function getPageContent(string $label, $locale)
    {
        $page = $this->doctrine->getRepository(Page::class)->findOneBy(['label' => $label]);
        $regions = $page->getRegions();

        $data = [];
        foreach ($regions as $r) {
            $dataOfRegion = self::findNodesByRegion($r, $locale, $r->getCount());
            $data[$r->getLabel()] = $dataOfRegion;
            // $data['nodes'] = $dataOfRegion;
        }
        
        $data['page'] = self::getPageInfo($label);

        return array_merge($data, self::getMisc($locale));
    }
    
    public function getPageInfo(string $label)
    {
        $page = $this->doctrine->getRepository(Page::class)->findOneBy(['label' => $label]);

        $data = [
          'name' => $page->getName(),
          'label' => $label,
          'intro' => '',
        ];

        return $data;
    }
    
    public function getMisc(string $locale)
    {
        $data['conf'] = self::getConf($locale);

		return $data;
    }

    public function getConf(string $locale)
    {
		return self::findConfByLocale($locale);
    }
    
    public function getMenu(string $label)
    {
        return $this->doctrine->getRepository(Menu::class)->findOneBy(['label' => $label]);
    }
    
    public function getSome($nid = null)
    {
        $conf = $this->doctrine->getRepository(Conf::class)->find(1);
        $nodeRepo = $this->doctrine->getRepository(Node::class);
        $regions = $this->doctrine->getRepository(Region::class)->findAll();
        $arr = [
            'description' => $conf->getDescription(),
            'keywords' => $conf->getKeywords(),
            'site_name' => $conf->getSitename(),
            'address' => $conf->getAddress(),
            'phone' => $conf->getPhone(),
            'email' => $conf->getEmail(),
        ];
        
        if (!is_null($nid)) {
            $arr['node'] = $this->doctrine->getRepository(Node::class)->find($nid);
        }
        
        foreach($regions as $r ) {
            $limit = $r->getCount();
            if ($limit > 0) {
                $order = 'DESC';
            } else {
                $order = 'ASC';
            }
            if ($limit !== 0) {
                $arr[$r->getLabel()] = $nodeRepo->findBy(['region' => $r], ['id' => $order], abs($limit));
            } else {
                // $arr[$r->getLabel()] = $nodeRepo->findOneBy(['region' => $r]);
            }
        }
        
        return $arr;
    }
    
    public function getNodeByRegion(string $region, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByRegion(['region' => $region], $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByRegion(string $region, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByRegion(['region' => $region], $limit, $offset);
        return $nodes;
    }
    
    public function getNodeByTag(string $tag, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByTag(['tag' => $tag], $limit, $offset);
        return $nodes;
    }
    
    public function getTagByLabel(string $label)
    {
        $tag = $this->doctrine->getRepository(Tag::class)->findOneBy(['label' => $label]);
        return $tag;
    }
   
    public function get($nid, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->find($nid);
    }
    
    public function find($nid, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->find($nid);
    }
    
    public function findNodeByTag(string $tag, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByTag($tag, $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByCategory(string $category, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByCategory($category, $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByRegionAndLocale($region_label, $locale = null)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $region = $this->findOneBy(['label' => $region_label], Region::class);
      $node = $this->findOneBy(['language' => $language, 'regions' => $region]);
        
      return $node;
    }
    
    public function findNodesByRegionAndLocale($region_label, $locale)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $region = $this->findOneBy(['label' => $region_label], Region::class);
      $nodes = $this->findBy(['language' => $language, 'region' => $region]);
        
      return $nodes;
    }
    
    public function findNodesByRegion(Region $region, $locale = null, $limit = null, $offset = null)
    {
      return $this->doctrine->getRepository(Node::class)->findByRegion($region, $locale, $limit, $offset);
    }
    
    public function findNodesByRegionLabel(string $label, $locale = null, $limit = null, $offset = null)
    {
      return $this->doctrine->getRepository(Node::class)->findByRegionLabel($label, $locale, $limit, $offset);
    }
    
    public function findConfByLocale($locale)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $conf = $this->findOneBy(['language' => $language], Conf::class);
        
      return $conf;
    }

    /**
     * 
     */
    public function findByRegionLabelAndCriteria($region_label, $criteria, $locale = null, $limit = null, $offset = null, $order = 'DESC')
    {
      return $this->doctrine->getRepository(Node::class)->findByRegionLabelAndCriteria($region_label, $criteria, $locale, $limit, $offset, $order);
    }
    
    public function findBy($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findBy($criteria);
    }
    
    public function findOneBy($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findOneBy($criteria);
    }
    
    public function findAll($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findAll($criteria);
    }
    
    /*
     * Get all site basic infomation in one place, add logic as you need
     */
    public function getInfo(string $locale)
    {
      $conf = $this->findConfByLocale($locale);
      $categories = $this->findAll([], Category::class);
      // $more = $this->findAll([], More::class);
      
      return [
        'conf' => $conf,
        'categories' => $categories,
        // 'more' => $more,
      ];
    }
    
    public function findNodeByCategoryAndRegion($cate_label, $region_label, int $limit)
    {
      return $this->doctrine->getRepository(Node::class)
                            ->findByCategoryAndRegion(['category' => $cate_label, 'region' => $region_label], [], $limit)
                        ;
    }
    
    public function findNodeByCategoryAndTag($cate_label, $tag_label, int $limit)
    {
      return $this->doctrine->getRepository(Node::class)
                            ->findByCategoryAndTag(['category' => $cate_label, 'tag' => $tag_label], [], $limit)
                        ;
    }

    public function getOrder(int $oid)
    {
        return $this->doctrine->getRepository(Order::class)->find($oid);
    }

    public function getOrderBySn(string $sn)
    {
        return $this->doctrine->getRepository(Order::class)->findOneBy(['sn' => $sn]);
    }

    public function getNodeComments(Node $node)
    {
        $data = [];
        foreach($node->getComments() as $c){
            array_push($data, self::formatComment($c));
        }

        return $data;
    }
}
