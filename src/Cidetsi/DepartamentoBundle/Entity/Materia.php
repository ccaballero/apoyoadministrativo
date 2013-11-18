<?php

namespace Cidetsi\DepartamentoBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

class Materia
{
    private $id;
    private $name;
    private $code;
    private $type;
    private $level;
    private $prerequisitos;

    public function __construct() {
        $this->prerequisitos = new \Doctrine\Common\Collections\ArrayCollection();
    }

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

    public function setCode($code) {
        $this->code = $code;
        return $this;
    }

    public function getCode() {
        return $this->code;
    }

    public function setType($type) {
        $this->type = $type;
        return $this;
    }

    public function getType() {
        return $this->type;
    }

    public function setLevel($level) {
        $this->level = $level;
        return $this;
    }

    public function getLevel() {
        return $this->level;
    }

    public function addPrerequisito(\Cidetsi\DepartamentoBundle\Entity\Materia $prerequisitos) {
        $this->prerequisitos[] = $prerequisitos;
        return $this;
    }

    public function removePrerequisito(\Cidetsi\DepartamentoBundle\Entity\Materia $prerequisitos) {
        $this->prerequisitos->removeElement($prerequisitos);
    }

    public function getPrerequisitos() {
        return $this->prerequisitos;
    }
}