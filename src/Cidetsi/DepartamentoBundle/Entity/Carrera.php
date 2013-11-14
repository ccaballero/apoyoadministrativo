<?php

namespace Cidetsi\DepartamentoBundle\Entity;

class Carrera
{
    private $id;
    private $name;
    private $abbreviation;
    private $planes;
    private $departamento;

    public function __construct() {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    public function getId() {
        return $this->id;
    }

    public function setName($name) {
        $this->name = $name;
        return $this;
    }

    public function getName() {
        return $this->name;
    }

    public function setAbbreviation($abbreviation) {
        $this->abbreviation = $abbreviation;
        return $this;
    }

    public function getAbbreviation() {
        return $this->abbreviation;
    }

    public function addPlan(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes) {
        $this->planes[] = $planes;
        return $this;
    }

    public function removePlan(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes) {
        $this->planes->removeElement($planes);
    }

    public function getPlanes() {
        return $this->planes;
    }

    public function setDepartamento(\Cidetsi\DepartamentoBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function getDepartamento() {
        return $this->departamento;
    }

    /**
     * Add planes
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes
     * @return Carrera
     */
    public function addPlane(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes)
    {
        $this->planes[] = $planes;
    
        return $this;
    }

    /**
     * Remove planes
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes
     */
    public function removePlane(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $planes)
    {
        $this->planes->removeElement($planes);
    }
}