<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\ORM\EntityRepository;

class DepartamentoRepository extends EntityRepository
{
    public function findDocentes($departamento) {
        $em = $this->getEntityManager();
        $qb = $em->createQueryBuilder();

        $qb->select('u')
           ->from('Grupo', 'g')
           ->leftJoin('g.docentes', $alias)
           ->where('u.id = ?1')
           ->orderBy('u.name', 'ASC');

        $query = $qb->getQuery();
        return $query->getResult();
    }
}
