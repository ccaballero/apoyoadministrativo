<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Departamento
 */
class Departamento
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $name;

    /**
     * @var string
     */
    private $abbreviation;

    /**
     * @var string
     */
    private $facultad;

    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $carreras;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->carreras = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     * @return Departamento
     */
    public function setName($name)
    {
        $this->name = $name;
    
        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set abbreviation
     *
     * @param string $abbreviation
     * @return Departamento
     */
    public function setAbbreviation($abbreviation)
    {
        $this->abbreviation = $abbreviation;
    
        return $this;
    }

    /**
     * Get abbreviation
     *
     * @return string 
     */
    public function getAbbreviation()
    {
        return $this->abbreviation;
    }

    /**
     * Set facultad
     *
     * @param string $facultad
     * @return Departamento
     */
    public function setFacultad($facultad)
    {
        $this->facultad = $facultad;
    
        return $this;
    }

    /**
     * Get facultad
     *
     * @return string 
     */
    public function getFacultad()
    {
        return $this->facultad;
    }

    /**
     * Add carreras
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\Carrera $carreras
     * @return Departamento
     */
    public function addCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carreras)
    {
        $this->carreras[] = $carreras;
    
        return $this;
    }

    /**
     * Remove carreras
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\Carrera $carreras
     */
    public function removeCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carreras)
    {
        $this->carreras->removeElement($carreras);
    }

    /**
     * Get carreras
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getCarreras()
    {
        return $this->carreras;
    }
}
