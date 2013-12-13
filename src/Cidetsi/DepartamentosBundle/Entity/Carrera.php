<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="carrera")
*/
class Carrera
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\ManyToOne(targetEntity="Departamento",inversedBy="carreras")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     **/
    private $departamento;

    /**
     * @ORM\Column(type="string",length=128,unique=true)
     */
    private $name;

    /**
     * @ORM\Column(type="string",length=32,unique=true)
     */
    private $abbreviation;
    
    /**
     * @ORM\Column(type="status")
     */
    private $status = 'enabled';
    
    /**
     * @ORM\Column(type="datetime")
     */
    private $tsregister;

    public function __construct() {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getName() { return $this->name; }
    public function getAbbreviation() { return $this->abbreviation; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function setDepartamento(\Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setName($name) {
        $this->name = $name;
        return $this;
    }

    public function setStatus($status) {
        $this->status = $status;
        return $this;
    }

    public function setAbbreviation($abbreviation) {
        $this->abbreviation = $abbreviation;
        return $this;
    }

//    public function addPlan(\Cidetsi\DepartamentosBundle\Entity\PlanEstudio $plan) {
//        $this->planes[] = $plan;
//        return $this;
//    }
//
//    public function removePlan(\Cidetsi\DepartamentosBundle\Entity\PlanEstudio $plan) {
//        $this->planes->removeElement($plan);
//    }
//
//    public function getPlanes() {
//        return $this->planes;
//    }
}
