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
}
