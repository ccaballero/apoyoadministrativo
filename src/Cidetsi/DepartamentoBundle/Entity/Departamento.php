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
     * @var string
     */
    private $facultad;


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
     * @var string
     */
    private $abbrevation;


    /**
     * Set abbrevation
     *
     * @param string $abbrevation
     * @return Departamento
     */
    public function setAbbrevation($abbrevation)
    {
        $this->abbrevation = $abbrevation;
    
        return $this;
    }

    /**
     * Get abbrevation
     *
     * @return string 
     */
    public function getAbbrevation()
    {
        return $this->abbrevation;
    }
    /**
     * @var string
     */
    private $abbreviation;


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
}