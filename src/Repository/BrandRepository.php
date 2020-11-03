<?php

namespace App\Repository;

use App\Entity\Brand;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Brand|null find($id, $lockMode = null, $lockVersion = null)
 * @method Brand|null findOneBy(array $criteria, array $orderBy = null)
 * @method Brand[]    findAll()
 * @method Brand[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class BrandRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Brand::class);
    }

    /**
     * @return Brand[] Returns an array of Brand objects
     */
    public function findByDeletedAt()
    {
        return $this->createQueryBuilder('b')
            ->andWhere('b.deleted_at is NULL')
            ->orderBy('b.id', 'ASC')
            ->getQuery()
            ->getResult()
            ;
    }
}
