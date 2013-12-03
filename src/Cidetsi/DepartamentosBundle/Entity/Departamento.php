<?php

namespace Cidetsi\DepartamentosBundle\Entity;

class Departamento
{
    private $id;
    private $name;
    private $status = 'enabled';
    private $abbreviation;
    private $facultad;
    private $carreras;

    public function __construct() {
        $this->carreras = new \Doctrine\Common\Collections\ArrayCollection();
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

    public function setFacultad($facultad) {
        $this->facultad = $facultad;
        return $this;
    }

    public function getFacultad() {
        return $this->facultad;
    }

    public function addCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carreras) {
        $this->carreras[] = $carreras;
        return $this;
    }

    public function removeCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carreras) {
        $this->carreras->removeElement($carreras);
    }

    public function getCarreras() {
        return $this->carreras;
    }

    public function isEmpty() {
        return count($this->getCarreras()) == 0;
    }

    public function __toString() {
        return $this->getName();
    }
}