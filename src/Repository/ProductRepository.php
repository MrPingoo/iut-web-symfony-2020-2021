<?php

namespace App\Repository;

use App\Entity\Category;
use App\Entity\Product;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Product|null find($id, $lockMode = null, $lockVersion = null)
 * @method Product|null findOneBy(array $criteria, array $orderBy = null)
 * @method Product[]    findAll()
 * @method Product[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProductRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Product::class);
    }

    /**
     * @return Product[] Returns an array of Brand objects
     */
    public function findByDeletedAt($sort = null)
    {
        $q = $this->createQueryBuilder('p')
            ->andWhere('p.deletedAt is NULL')
            ;

        if (!empty($sort)) {
            $q
                ->orderBy($sort, 'ASC');
        } else {
            $q
                ->orderBy('p.id', 'ASC');
        }

        return $q
            ->getQuery()
            ->getResult();
    }

    /**
     * @return Product[] Returns an array of Brand objects
     */
    public function findByArgs($args)
    {
        $q = $this->createQueryBuilder('p')
            ->join('p.categories', 'c')
            ->andWhere('p.deletedAt is NULL')
        ;

        if (isset($args['q']) && !empty($args['q'])) {
            $q->andWhere('p.name LIKE :q OR p.description LIKE :q')
                ->setParameter('q', '%' . $args['q'] . '%');
        }

        if (isset($args['categories']) && !empty($args['categories'])) {
            $cats = [];

            /** @var Category $cat */
            foreach ($args['categories'] as $cat) {
                $cats[] = $cat->getId();
            }
            if (!empty($cats)) {
                $q->andWhere('c.category IN (:cats)')
                    ->setParameter('cats', $cats);
            }
        }

        $q
            ->orderBy('p.id', 'ASC');

        return $q
            ->getQuery()
            ->getResult();
    }

    // /**
    //  * @return Product[] Returns an array of Product objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Product
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
