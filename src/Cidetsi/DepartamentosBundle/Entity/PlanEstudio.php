<?php

namespace Cidetsi\DepartamentosBundle\Entity;

class PlanEstudio
{
    private $id;
    private $name;
    private $status = 'enabled';
    private $code;
    private $carrera;

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

    public function setCode($code) {
        $this->code = $code;
        return $this;
    }

    public function getCode() {
        return $this->code;
    }

    public function setCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carrera = null) {
        $this->carrera = $carrera;
        return $this;
    }

    public function getCarrera() {
        return $this->carrera;
    }

    public function __toString() {
        return $this->name . ' (' . $this->code . ')';
    }
    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $plan_materias;

    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $materias;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->plan_materias = new \Doctrine\Common\Collections\ArrayCollection();
        $this->materias = new \Doctrine\Common\Collections\ArrayCollection();
    }
    
    /**
     * Add plan_materias
     *
     * @param \Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias
     * @return PlanEstudio
     */
    public function addPlanMateria(\Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias)
    {
        $this->plan_materias[] = $planMaterias;
    
        return $this;
    }

    /**
     * Remove plan_materias
     *
     * @param \Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias
     */
    public function removePlanMateria(\Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias)
    {
        $this->plan_materias->removeElement($planMaterias);
    }

    /**
     * Get plan_materias
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getPlanMaterias()
    {
        return $this->plan_materias;
    }

    /**
     * Add materias
     *
     * @param \Cidetsi\DepartamentosBundle\Entity\Materia $materias
     * @return PlanEstudio
     */
    public function addMateria(\Cidetsi\DepartamentosBundle\Entity\Materia $materias)
    {
        $this->materias[] = $materias;
    
        return $this;
    }

    /**
     * Remove materias
     *
     * @param \Cidetsi\DepartamentosBundle\Entity\Materia $materias
     */
    public function removeMateria(\Cidetsi\DepartamentosBundle\Entity\Materia $materias)
    {
        $this->materias->removeElement($materias);
    }

    /**
     * Get materias
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getMaterias()
    {
        return $this->materias;
    }
}