<?php

namespace Cidetsi\DepartamentoBundle\Entity;

class Materia
{
    private $id;
    private $name;
    private $code;
    private $status;
    private $type;
    private $level;

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

    public function setStatus($status) {
        $this->status = $status;
        return $this;
    }

    public function getStatus() {
        return $this->status;
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
}