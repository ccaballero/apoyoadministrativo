<?php

namespace Cidetsi\MateriasBundle\Controller;

use Cidetsi\BaseBundle\Controller\CrudController;

class MateriaController extends CrudController
{
    public $resource = 'materia';
    public $repository = 'CidetsiMateriasBundle:Materia';
    public $orderBy = array('ident' => 'asc');
    public $form = 'Cidetsi\MateriasBundle\Form\MateriaForm';
    public $entity = 'Cidetsi\MateriasBundle\Entity\Materia';

    public $tpl_commons = array(
        'title_list'   => 'Materias',
        'title_create' => 'Agregar materia',
        'title_update' => 'Editar materia',
        'title_delete' => 'Eliminar materia',
        'url_list'     => 'materia',
        'url_element'  => 'materia_read',
    );

    public function listByDepartamentoAction($departamento) {
        $materias = array();
        foreach ($departamento->getMaterias() as $materia) {
            $malla = array();
            foreach ($materia->getMalla() as $_m) {
                if (array_key_exists($_m->getCode(), $malla)) {
                    $malla[$_m->getCode()]['carrera'][] = $_m->getCarrera();
                } else {
                    $malla[$_m->getCode()] = array(
                        'level' => $_m->getLevel(),
                        'code' => $_m->getCode(),
                        'name' => $_m->getName(),
                        'carrera' => array(
                            $_m->getCarrera(),
                        ),
                    );
                }
            }
            $materias[$materia->getIdent()] = $malla;
        }

        return $this->render(
            'CidetsiMateriasBundle:Materia:list.departamento.html.twig', array(
            'materias' => $materias,
        ));
    }
}
