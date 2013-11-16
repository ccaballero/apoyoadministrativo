<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

class PlanEstudio
{
    private $id;
    private $name;
    private $code;
    private $carrera;
    private $materias;

    public function __construct() {
        $this->materias = new \Doctrine\Common\Collections\ArrayCollection();
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

    public function setCode($code) {
        $this->code = $code;
        return $this;
    }

    public function getCode() {
        return $this->code;
    }

    public function setCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carrera = null) {
        $this->carrera = $carrera;
        return $this;
    }

    public function getCarrera() {
        return $this->carrera;
    }

    public function addMateria(\Cidetsi\DepartamentoBundle\Entity\Materia $materias) {
        $this->materias[] = $materias;
        return $this;
    }

    public function removeMateria(\Cidetsi\DepartamentoBundle\Entity\Materia $materias) {
        $this->materias->removeElement($materias);
    }

    public function getMaterias() {
        return $this->materias;
    }

    public function __toString() {
        return $this->name . ' (' . $this->code . ')';
    }
}
