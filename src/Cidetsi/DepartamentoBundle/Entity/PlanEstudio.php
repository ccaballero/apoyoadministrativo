<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * PlanEstudio
 */
class PlanEstudio
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
    private $code;

    /**
     * @var string
     */
    private $status;

    /**
     * @var \Cidetsi\DepartamentoBundle\Entity\Carrera
     */
    private $carrera;


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
     * @return PlanEstudio
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
     * Set code
     *
     * @param string $code
     * @return PlanEstudio
     */
    public function setCode($code)
    {
        $this->code = $code;
    
        return $this;
    }

    /**
     * Get code
     *
     * @return string 
     */
    public function getCode()
    {
        return $this->code;
    }

    /**
     * Set status
     *
     * @param string $status
     * @return PlanEstudio
     */
    public function setStatus($status)
    {
        $this->status = $status;
    
        return $this;
    }

    /**
     * Get status
     *
     * @return string 
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set carrera
     *
     * @param \Cidetsi\DepartamentoBundle\Entity\Carrera $carrera
     * @return PlanEstudio
     */
    public function setCarrera(\Cidetsi\DepartamentoBundle\Entity\Carrera $carrera = null)
    {
        $this->carrera = $carrera;
    
        return $this;
    }

    /**
     * Get carrera
     *
     * @return \Cidetsi\DepartamentoBundle\Entity\Carrera 
     */
    public function getCarrera()
    {
        return $this->carrera;
    }
}