<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="plan_estudio")
*/
class PlanEstudio
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     **/
    private $departamento;

    /**
     * @ORM\ManyToOne(targetEntity="Carrera",inversedBy="planes")
     * @ORM\JoinColumn(name="carrera",referencedColumnName="ident")
     **/
    private $carrera;

    /**
     * @ORM\Column(type="string",length=128,unique=true)
     */
    private $name;

    /**
     * @ORM\Column(type="string",length=16,unique=true)
     */
    private $code;

    /**
     * @ORM\Column(type="status")
     */
    private $status = 'enabled';

    /**
     * @ORM\Column(type="datetime")
     */
    private $tsregister;

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getCarrera() { return $this->carrera; }
    public function getName() { return $this->name; }
    public function getCode() { return $this->code; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function setDepartamento(\Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setCarrera(\Cidetsi\DepartamentosBundle\Entity\Carrera $carrera = null) {
        $this->carrera = $carrera;
        return $this;
    }

    public function setName($name) {
        $this->name = $name;
        return $this;
    }

    public function setCode($code) {
        $this->code = $code;
        return $this;
    }

    public function setStatus($status) {
        $this->status = $status;
        return $this;
    }

    public function setTsregister($tsregister) {
        $this->tsregister = $tsregister;
        return $this;
    }

    public function __toString() {
        return $this->getName() . ' (' . $this->getCode() . ')';
    }

    public function isEnabled() {
        return $this->getStatus() == 'enabled';
    }

//    private $plan_materias;
//    private $materias;

//    public function __construct()
//    {
//        $this->plan_materias = new \Doctrine\Common\Collections\ArrayCollection();
//        $this->materias = new \Doctrine\Common\Collections\ArrayCollection();
//    }
//
//    public function addPlanMateria(\Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias)
//    {
//        $this->plan_materias[] = $planMaterias;
//
//        return $this;
//    }
//
//    public function removePlanMateria(\Cidetsi\DepartamentosBundle\Entity\PlanMateria $planMaterias)
//    {
//        $this->plan_materias->removeElement($planMaterias);
//    }
//
//    public function getPlanMaterias()
//    {
//        return $this->plan_materias;
//    }
//
//    public function addMateria(\Cidetsi\DepartamentosBundle\Entity\Materia $materias)
//    {
//        $this->materias[] = $materias;
//        return $this;
//    }
//
//    public function removeMateria(\Cidetsi\DepartamentosBundle\Entity\Materia $materias)
//    {
//        $this->materias->removeElement($materias);
//    }
//
//    public function getMaterias()
//    {
//        return $this->materias;
//    }
}
