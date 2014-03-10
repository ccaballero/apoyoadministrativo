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
     */
    private $departamento;

    /**
     * @ORM\Column(type="status")
     */
    private $status = 'enabled';

    /**
     * @ORM\Column(type="datetime")
     */
    private $tsregister;

    /**
     * @ORM\OneToMany(
     * targetEntity="\Cidetsi\DepartamentosBundle\Entity\MallaCurricular",
     * mappedBy="materia")
     */
    private $malla;

    /**
     * @ORM\OneToMany(targetEntity="Grupo",mappedBy="materia")
     */
    private $grupos;

    public function __construct() {
        $this->malla = new ArrayCollection();
        $this->grupos = new ArrayCollection();
    }

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function getMalla() { return $this->malla; }
    public function getGrupos() { return $this->grupos; }

    public function setDepartamento(
        \Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
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

    public function setMalla($malla) {
        $this->malla = $malla;
        return $this;
    }

    public function setGrupos($grupos) {
        $this->grupos = $grupos;
        return $this;
    }

    public function addMalla(
        \Cidetsi\DepartamentosBundle\Entity\MallaCurricular $malla) {
        $this->malla[] = $malla;
        return $this;
    }

    public function removeMalla(
        \Cidetsi\DepartamentosBundle\Entity\MallaCurricular $malla) {
        $this->malla->removeElement($malla);
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
        return $this->getIdent();
    }

    public function getName() {
        $malla = $this->getMalla();
        $name = '';

        switch (count($malla)) {
        case 0:
            $name = 'No definida';
            break;
        case 1:
            $name = $malla[0]->getName();
            break;
        default:
            $names = array();
            foreach ($malla as $_m) {
                $names[] = $_m->getName();
            }
            $names = array_unique($names);
            $name = implode(', ', $names);
        }
        return $name;
    }

    public function getCode() {
        $malla = $this->getMalla();
        $code = '';

        switch (count($malla)) {
        case 0:
            $code = '-------';
            break;
        case 1:
            $code = $malla[0]->getCode();
            break;
        default:
            $codes = array();
            foreach ($malla as $_m) {
                $codes[] = $_m->getCode();
            }
            $codes = array_unique($codes);
            $code = implode(', ', $codes);
        }
        return $code;
    }

    public function isEnabled() {
        return $this->getStatus() == 'enabled';
    }

    public function getLabel() {
        return $this->getIdent();
    }

    public function getSlug() {
        return $this->getIdent();
    }

    public function isEmpty() {
        return count($this->getGrupos()) == 0;
    }
}

