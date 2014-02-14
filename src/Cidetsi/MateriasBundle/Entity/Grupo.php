<?php

namespace Cidetsi\MateriasBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="grupo")
*/
class Grupo implements \Cidetsi\BaseBundle\Entity\Resource
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\DepartamentosBundle\Entity\Departamento")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     **/
    private $departamento;

    /**
     * @ORM\ManyToOne(targetEntity="Materia",inversedBy="grupos")
     * @ORM\JoinColumn(name="materia",referencedColumnName="ident")
     **/
    private $materia;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\GestionesBundle\Entity\Gestion",
     * inversedBy="grupos")
     * @ORM\JoinColumn(name="gestion",referencedColumnName="ident")
     **/
    private $gestion;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\DocentesBundle\Entity\Docente",
     * inversedBy="grupos")
     * @ORM\JoinColumn(name="docente",referencedColumnName="ident")
     **/
    private $docente;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\AuxiliaresBundle\Entity\Auxiliar",
     * inversedBy="grupos")
     * @ORM\JoinColumn(name="auxiliar",referencedColumnName="ident")
     **/
    //private $auxiliar;

    /**
     * @ORM\ManyToOne(
     * targetEntity="\Cidetsi\HorariosBundle\Entity\Horario",
     * inversedBy="grupos")
     * @ORM\JoinColumn(name="horario",referencedColumnName="ident")
     **/
    //private $horario;

    /**
     * @ORM\Column(type="string",length=128,unique=true)
     */
    private $name;

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
    public function getMateria() { return $this->materia; }
    public function getGestion() { return $this->gestion; }
    public function getDocente() { return $this->docente; }
    //public function getAuxilar() { return $this->auxiliar; }
    //public function getHorario() { return $this->horario; }
    public function getName() { return $this->name; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function setDepartamento(
        \Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setMateria(
        \Cidetsi\MateriasBundle\Entity\Materia $materia = null) {
        $this->materia = $materia;
        return $this;
    }

    public function setGestion(
        \Cidetsi\GestionesBundle\Entity\Gestion $gestion = null) {
        $this->gestion = $gestion;
        return $this;
    }
    
    public function setDocente(
        \Cidetsi\DocentesBundle\Entity\Docente $docente = null) {
        $this->docente = $docente;
        return $this;
    }

    /*public function setAuxiliar(
        \Cidetsi\AuxiliaresBundle\Entity\Auxiliar $auxiliar = null) {
        $this->auxiliar = $auxiliar;
        return $this;
    }*/

    /*public function setHorario(
        \Cidetsi\HorariosBundle\Entity\Horario $horario = null) {
        $this->auxiliar = $auxiliar;
        return $this;
    }*/

    public function setName($name) {
        $this->name = $name;
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
        return true;
    }
}

