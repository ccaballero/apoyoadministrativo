<?php

namespace Cidetsi\MateriasBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * PlanMateria
 */
class PlanMateria
{
    /**
     * @var string
     */
    private $type;

    /**
     * @var string
     */
    private $level;

    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $prerequisitos;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->prerequisitos = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    /**
     * Set type
     *
     * @param string $type
     * @return PlanMateria
     */
    public function setType($type)
    {
        $this->type = $type;
    
        return $this;
    }

    /**
     * Get type
     *
     * @return string 
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * Set level
     *
     * @param string $level
     * @return PlanMateria
     */
    public function setLevel($level)
    {
        $this->level = $level;
    
        return $this;
    }

    /**
     * Get level
     *
     * @return string 
     */
    public function getLevel()
    {
        return $this->level;
    }

    /**
     * Add prerequisitos
     *
     * @param \Cidetsi\MateriasBundle\Entity\Materia $prerequisitos
     * @return PlanMateria
     */
    public function addPrerequisito(\Cidetsi\MateriasBundle\Entity\Materia $prerequisitos)
    {
        $this->prerequisitos[] = $prerequisitos;
    
        return $this;
    }

    /**
     * Remove prerequisitos
     *
     * @param \Cidetsi\MateriasBundle\Entity\Materia $prerequisitos
     */
    public function removePrerequisito(\Cidetsi\MateriasBundle\Entity\Materia $prerequisitos)
    {
        $this->prerequisitos->removeElement($prerequisitos);
    }

    /**
     * Get prerequisitos
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getPrerequisitos()
    {
        return $this->prerequisitos;
    }
    /**
     * @var \Cidetsi\DepartamentosBundle\Entity\PlanEstudio
     */
    private $plan_estudio;

    /**
     * @var \Cidetsi\MateriasBundle\Entity\Materia
     */
    private $materia;


    /**
     * Set plan_estudio
     *
     * @param \Cidetsi\DepartamentosBundle\Entity\PlanEstudio $planEstudio
     * @return PlanMateria
     */
    public function setPlanEstudio(\Cidetsi\DepartamentosBundle\Entity\PlanEstudio $planEstudio = null)
    {
        $this->plan_estudio = $planEstudio;
    
        return $this;
    }

    /**
     * Get plan_estudio
     *
     * @return \Cidetsi\DepartamentosBundle\Entity\PlanEstudio 
     */
    public function getPlanEstudio()
    {
        return $this->plan_estudio;
    }

    /**
     * Set materia
     *
     * @param \Cidetsi\MateriasBundle\Entity\Materia $materia
     * @return PlanMateria
     */
    public function setMateria(\Cidetsi\MateriasBundle\Entity\Materia $materia = null)
    {
        $this->materia = $materia;
    
        return $this;
    }

    /**
     * Get materia
     *
     * @return \Cidetsi\MateriasBundle\Entity\Materia 
     */
    public function getMateria()
    {
        return $this->materia;
    }
    /**
     * @var integer
     */
    private $id;


    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }
}