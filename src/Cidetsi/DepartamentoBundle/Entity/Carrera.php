<?php

namespace Cidetsi\DepartamentoBundle\Entity;

class Carrera
{
    private $id;
    private $name;
    private $status = 'enabled';
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

    public function setStatus($status) {
        $this->status = $status;
        return $this;
    }

    public function getStatus() {
        return $this->status;
    }

    public function setAbbreviation($abbreviation) {
        $this->abbreviation = $abbreviation;
        return $this;
    }

    public function getAbbreviation() {
        return $this->abbreviation;
    }

    public function addPlan(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $plan) {
        $this->planes[] = $plan;
        return $this;
    }

    public function removePlan(\Cidetsi\DepartamentoBundle\Entity\PlanEstudio $plan) {
        $this->planes->removeElement($plan);
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
}
