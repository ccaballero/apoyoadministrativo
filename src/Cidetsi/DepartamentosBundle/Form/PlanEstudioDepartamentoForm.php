<?php

namespace Cidetsi\DepartamentosBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class PlanEstudioDepartamentoForm extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options) {
        $builder->add('carrera', 'entity', array(
                    'class' => 'CidetsiDepartamentosBundle:Carrera'))
                ->add('name', 'text', array(
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
