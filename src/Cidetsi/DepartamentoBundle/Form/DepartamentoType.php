<?php

namespace Cidetsi\DepartamentoBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class DepartamentoType extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options) {
        $builder->add('name', 'text', array('required' => true))
                ->add('abbreviation', 'text', array('required' => true))
                ->add('facultad', 'text', array('required' => true));
    }

    /**
     * @param OptionsResolverInterface $resolver
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver) {
        $resolver->setDefaults(array(
            'data_class' => 'Cidetsi\DepartamentoBundle\Entity\Departamento'
        ));
    }

    /**
     * @return string
     */
    public function getName() {
        return 'cidetsi_departamentobundle_departamento';
    }
}
