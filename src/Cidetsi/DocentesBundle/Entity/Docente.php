<?php

namespace Cidetsi\DocentesBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
* @ORM\Entity
* @ORM\Table(name="docente")
*/
class Docente
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $ident;

    /**
     * @ORM\Column(type="string",length=64,unique=true,nullable=false)
     */
    private $ci;

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $apellido_paterno;

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $apellido_materno;

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $nombres;

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $diploma = '';

    /**
     * @ORM\Column(type="string",length=128)
     */
    private $titulo = '';

    /**
     * @ORM\Column(type="datetime")
     */
    private $tsregister;

    /**
     * @ORM\Column(type="string",length=15,unique=true)
     */
    public $pg_id;

    /**
     * @ORM\OneToMany(targetEntity="\Cidetsi\MateriasBundle\Entity\Grupo",mappedBy="docente")
     **/
    private $grupos;

    public function getIdent() { return $this->ident; }
    public function getCi() { return $this->ci; }
    public function getApellidoPaterno() { return $this->apellido_paterno; }
    public function getApellidoMaterno() { return $this->apellido_materno; }
    public function getNombres() { return $this->nombres; }
    public function getDiploma() { return $this->diploma; }
    public function getTitulo() { return $this->titulo; }
    public function getTsregister() { return $this->tsregister; }

    public function getGrupos() { return $this->grupos; }

    public function setCi($ci) {
        $this->ci = $ci;
        return $this;
    }

    public function setApellidoPaterno($apellido_paterno) {
        $this->apellido_paterno = $apellido_paterno;
        return $this;
    }

    public function setApellidoMaterno($apellido_materno) {
        $this->apellido_materno = $apellido_materno;
        return $this;
    }

    public function setNombres($nombres) {
        $this->nombres = $nombres;
        return $this;
    }

    public function setDiploma($diploma) {
        $this->diploma = $diploma;
        return $this;
    }

    public function setTitulo($titulo) {
        $this->titulo = $titulo;
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
        return $this->getCi();
    }
}
