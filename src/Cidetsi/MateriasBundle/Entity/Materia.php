<?php

namespace Cidetsi\MateriasBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="materia")
*/
class Materia implements \Cidetsi\BaseBundle\Entity\Resource
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\DepartamentosBundle\Entity\Departamento",
     * inversedBy="materias")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     **/
    private $departamento;

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

    /**
     * @ORM\OneToMany(targetEntity="Grupo",mappedBy="materia")
     **/
    private $grupos;

    public function __construct() {
        $this->grupos = new ArrayCollection();
    }

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getName() { return $this->name; }
    public function getCode() { return $this->code; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function getGrupos() { return $this->grupos; }

    public function setDepartamento(
        \Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
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

    public function setGrupos($grupos) {
        $this->grupos = $grupos;
        return $this;
    }

    public function addGrupo(\Cidetsi\MateriasBundle\Entity\Grupo $grupo) {
        $this->grupos[] = $grupo;
        return $this;
    }

    public function removeGrupo(\Cidetsi\MateriasBundle\Entity\Grupo $grupo) {
        $this->grupos->removeElement($grupo);
        return $this;
    }

    public function __toString() {
        return $this->getName();
    }

    public function isEnabled() {
        return $this->getStatus() == 'enabled';
    }

    public function getLabel() {
        return $this->getName();
    }

    public function getSlug() {
        return $this->getIdent();
    }

    public function isEmpty() {
        return count($this->getGrupos()) == 0;
    }
}

