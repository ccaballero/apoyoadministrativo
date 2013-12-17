<?php

namespace Cidetsi\MateriasBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="grupo")
*/
class Grupo
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\ManyToOne(targetEntity="\Cidetsi\DepartamentosBundle\Entity\Departamento")
     * @ORM\JoinColumn(name="departamento",referencedColumnName="ident")
     **/
    private $departamento;

    /**
     * @ORM\ManyToOne(targetEntity="Materia",inversedBy="grupos")
     * @ORM\JoinColumn(name="materia",referencedColumnName="ident")
     **/
    private $materia;

    /**
     * @ORM\ManyToOne(targetEntity="\Cidetsi\GestionesBundle\Entity\Gestion",inversedBy="grupos")
     * @ORM\JoinColumn(name="gestion",referencedColumnName="ident")
     **/
    private $gestion;

    /**
     * @ORM\ManyToOne(targetEntity="\Cidetsi\DocentesBundle\Entity\Docente",inversedBy="grupos")
     * @ORM\JoinColumn(name="docente",referencedColumnName="ident")
     **/
    private $docente;

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

    /**
     * @ORM\Column(type="string",length=15,unique=true)
     */
    public $pg_id;

    public function getIdent() { return $this->ident; }
    public function getDepartamento() { return $this->departamento; }
    public function getMateria() { return $this->materia; }
    public function getGestion() { return $this->gestion; }
    public function getDocente() { return $this->docente; }
    public function getName() { return $this->name; }
    public function getStatus() { return $this->status; }
    public function getTsregister() { return $this->tsregister; }

    public function setDepartamento(\Cidetsi\DepartamentosBundle\Entity\Departamento $departamento = null) {
        $this->departamento = $departamento;
        return $this;
    }

    public function setMateria(\Cidetsi\MateriasBundle\Entity\Materia $materia = null) {
        $this->materia = $materia;
        return $this;
    }

    public function setGestion(\Cidetsi\GestionesBundle\Entity\Gestion $gestion = null) {
        $this->gestion = $gestion;
        return $this;
    }
    
    public function setDocente(\Cidetsi\DocentesBundle\Entity\Docente $docente = null) {
        $this->docente = $docente;
        return $this;
    }

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
}
