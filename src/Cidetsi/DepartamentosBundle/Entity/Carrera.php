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
     * @ORM\Column(type="string",length=32)
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

    /**
     * @ORM\OneToMany(targetEntity="PlanEstudio",mappedBy="carrera")
     **/
    private $planes;

    public function __construct() {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getName() { return $this->name; }
    public function getAbbreviation() { return $this->abbreviation; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function getPlanes() { return $this->planes; }

    public function setDepartamento(\Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setName($name) {
        $this->name = $name;
        return $this;
    }

    public function setAbbreviation($abbreviation) {
        $this->abbreviation = $abbreviation;
        return $this;
    }

    public function setStatus($status) {
        $this->status = $status;
        return $this;
    }

    public function setTsregister($tsregister) {
        $this->tsregister = $tsregister;
        return $this;
    }

    public function setPlanes($planes) {
        $this->planes = $planes;
        return $this;
    }

    public function addPlan(\Cidetsi\DepartamentosBundle\Entity\PlanEstudio $plan) {
        $this->planes[] = $plan;
        return $this;
    }

    public function removePlan(\Cidetsi\DepartamentosBundle\Entity\PlanEstudio $plan) {
        $this->planes->removeElement($plan);
    }

    public function __toString() {
        return $this->getName();
    }

    public function getCode() {
        return $this->getAbbreviation();
    }

    public function isEmpty() {
        return count($this->getPlanes()) == 0;
    }

    public function isEnabled() {
        return $this->getStatus() == 'enabled';
    }
}

