<?php

namespace Cidetsi\DepartamentosBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class PlanEstudioForm extends AbstractType
{
    private $departamento = null;
    private $carrera = null;

    public function __construct($departamento = null, $carrera = null) {
        $this->departamento = $departamento;
        $this->carrera = $carrera;
    }

    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options) {
        if ($this->departamento == null) {
            $builder->add('departamento', 'entity', array(
                'class' => 'CidetsiDepartamentosBundle:Departamento'));
        }

        $departamento = $this->departamento; 
        $queryBuilder = function($repository) use ($departamento) {
            return $repository->createQueryBuilder('c')
                              ->where('c.departamento = :departamento')
                              ->setParameter('departamento', $departamento);
        };
        if ($this->carrera == null) {
            $builder->add('carrera', 'entity', array(
                'class' => 'CidetsiDepartamentosBundle:Carrera',
                'query_builder' => $queryBuilder,
                'required' => true,
            ));
        }
        
        $builder->add('name', 'text', array(
                      'required' => true,
                      'label' => 'Nombre:'))
                ->add('code', 'text', array(
                      'required' => true,
                      'label' => 'Código:'));
    }

    /**
     * @param OptionsResolverInterface $resolver
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver) {
        $resolver->setDefaults(array(
            'data_class' => 'Cidetsi\DepartamentosBundle\Entity\PlanEstudio'
        ));
    }

    /**
     * @return string
     */
    public function getName() {
        return 'planestudio';
    }
}
