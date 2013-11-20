<?php

namespace Cidetsi\DepartamentoBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class CarreraForm extends AbstractType
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
                    'label' => 'Abreviatura:'));
    }

    /**
     * @param OptionsResolverInterface $resolver
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver) {
        $resolver->setDefaults(array(
            'data_class' => 'Cidetsi\DepartamentoBundle\Entity\Carrera'
        ));
    }

    /**
     * @return string
     */
    public function getName() {
        return 'carrera';
    }
}
