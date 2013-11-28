<?php

namespace Cidetsi\DepartamentosBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class DepartamentoForm extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options) {
        $builder->add('name', 'text', array(
                    'required' => true,
                    'label' => 'Nombre:'))
                ->add('abbreviation', 'text', array(
                    'required' => true,
                    'label' => 'Abreviatura:'))
                ->add('facultad', 'text', array(
                    'required' => true,
                    'label' => 'Facultad:'));
    }

    /**
     * @param OptionsResolverInterface $resolver
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver) {
        $resolver->setDefaults(array(
            'data_class' => 'Cidetsi\DepartamentosBundle\Entity\Departamento'
        ));
    }

    /**
     * @return string
     */
    public function getName() {
        return 'departamento';
    }
}
