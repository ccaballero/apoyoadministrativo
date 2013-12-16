<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="departamento")
*/
class Departamento
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

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
     * @ORM\Column(type="string",length=64)
     */
    private $facultad = '';

    /**
     * @ORM\Column(type="datetime")
     */
    private $tsregister;

    /**
     * @ORM\OneToMany(targetEntity="Carrera",mappedBy="departamento")
     **/
    private $carreras;

    public function __construct() {
        $this->carreras = new ArrayCollection();
    }

    public function getIdent() {        return $this->ident; }
    public function getName() {         return $this->name; }
    public function getAbbreviation() { return $this->abbreviation; }
    public function getStatus() {       return $this->status; }
    public function getFacultad() {     return $this->facultad; }
    public function getTsregister() {   return $this->tsregister; }

    public function getCarreras() { return $this->carreras; }

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

    public function setFacultad($facultad) {
        $this->facultad = $facultad;
        return $this;
    }

    public function setTsregister($tsregister) {
        $this->tsregister = $tsregister;
        return $this;
    }

    public function setCarreras($carreras) {
        $this->carreras = $carreras;
    }

    public function addCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carrera) {
        $this->carreras[] = $carrera;
        return $this;
    }

    public function removeCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carrera) {
        $this->carreras->removeElement($carrera);
    }

    public function __toString() {
        return $this->getName();
    }

    public function isEmpty() {
        return count($this->getCarreras()) == 0;
    }
}
