<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

class Departamento
{
    private $id;
    private $name;
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

    public function addCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carreras) {
        $this->carreras[] = $carreras;
        return $this;
    }

    public function removeCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carreras) {
        $this->carreras->removeElement($carreras);
    }

    public function getCarreras() {
        return $this->carreras;
    }
}