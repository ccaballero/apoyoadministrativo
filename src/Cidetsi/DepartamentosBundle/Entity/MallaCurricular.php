<?php

namespace Cidetsi\DepartamentosBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="malla_curricular")
 */
class MallaCurricular
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\ManyToOne(targetEntity="Departamento")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     */
    private $departamento;

    /**
     * @ORM\ManyToOne(targetEntity="Carrera")
     * @ORM\JoinColumn(name="carrera",referencedColumnName="ident")
     */
    private $carrera;

    /**
     * @ORM\ManyToOne(targetEntity="PlanEstudio")
     * @ORM\JoinColumn(name="plan",referencedColumnName="ident")
     */
    private $plan;

    /**
     * @ORM\ManyToOne(targetEntity="Departamento")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     */
    private $departamento2;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\MateriasBundle\Entity\Materia")
     * @ORM\JoinColumn(name="materia",referencedColumnName="ident")
     */
    private $materia;

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $name;

    /**
     * @ORM\Column(type="string",length=16)
     */
    private $code;

    /**
     * @ORM\Column(type="string",length=2)
     */
    private $type;

    /**
     * @ORM\Column(type="string",length=1)
     */
    private $level;

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getCarrera() { return $this->carrera; }
    public function getPlan() { return $this->plan; }
    public function getDepartamento2() { return $this->departamento2; }
    public function getMateria() { return $this->materia; }
    public function getName() { return $this->name; }
    public function getCode() { return $this->code; }
    public function getType() { return $this->type; }
    public function getLevel() { return $this->level; }

    public function setDepartamento(
        \Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setCarrera(
        \Cidetsi\DepartamentosBundle\Entity\Carrera $carrera = null) {
        $this->carrera = $carrera;
        return $this;
    }

    public function setPlan(
        \Cidetsi\DepartamentosBundle\Entity\PlanEstudio $plan = null) {
        $this->plan = $plan;
        return $this;
    }

    public function setDepartamento2(
        \Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento2 = $departamento;
        return $this;
    }

    public function setMateria(
        \Cidetsi\MateriasBundle\Entity\Materia $materia = null) {
        $this->materia = $materia;
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

    public function setType($type) {
        $this->type = $type;
        return $this;
    }

    public function setLevel($level) {
        $this->level = $level;
        return $this;
    }

    public function __toString() {
        return $this->getName();
    }
}

