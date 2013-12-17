<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\ORM\EntityRepository;

class DepartamentoRepository extends EntityRepository
{
    public function findDocentes($departamento) {
        $em = $this->getEntityManager();
        $qb = $em->createQueryBuilder();

        $qb->select('d')
           ->from('\Cidetsi\DocentesBundle\Entity\Docente', 'd')
           ->leftJoin('d.grupos', 'g')
           ->where('g.departamento = :departamento')
           ->setParameter('departamento', $departamento->getIdent());

        $query = $qb->getQuery();
        return $query->getResult();
    }
}
