<?php

namespace Cidetsi\BaseBundle\Entity;

/** Decidi que por definición todo objeto debe proveer la siguiente información:
 *
 *  - Información sobre localización de recurso.
 *  - Nombre con el que debe reenderizarse sus referencias.
 *  - Estado actual del recurso.
 *  - Si el recurso esta vacio (que no tenga ninguna referencia hacia otro
 *    objeto.
 */

interface Resource {
    public function getStatus();
    public function isEnabled();

    public function getLabel();
    public function getSlug();

    public function isEmpty();
}

