<?php

namespace Cidetsi\DepartamentosBundle\Entity;

class Carrera
{
    private $id;
    private $departamento;
    private $name;
    private $abbreviation;
    private $status = 'enabled';
    private $tsregister;

    public function __construct() {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
    }

    public function getId() { return $this->id; }
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
