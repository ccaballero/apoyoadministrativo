<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Carrera
 */
class Carrera
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
     * @var \Doctrine\Common\Collections\Collection
     */
    private $planes;

    /**
     * @var \Cidetsi\DepartamentoBundle\Entity\Departamento
     */
    private $departamento;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
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
     * @return Carrera
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
     * @return Carrera
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

    /**
     * Get planes
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getPlanes()
    {
        return $this->planes;
    }

    /**
     * Set departamento
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\Departamento $departamento
     * @return Carrera
     */
    public function setDepartamento(\Cidetsi\DepartamentoBundle\Entity\Departamento $departamento = null)
    {
        $this->departamento = $departamento;
    
        return $this;
    }

    /**
     * Get departamento
     *
     * @return \Cidetsi\DepartamentoBundle\Entity\Departamento 
     */
    public function getDepartamento()
    {
        return $this->departamento;
    }
}
