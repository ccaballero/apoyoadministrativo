<?php

namespace Cidetsi\DocentesBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class DocenteForm extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options) {
        $builder->add('ci', 'text', array(
                    'required' => false,
                    'label' => 'Carnet de Identidad:'))
                ->add('apellido_paterno', 'text', array(
                    'required' => true,
                    'label' => 'Apellido Paterno (*):'))
                ->add('apellido_materno', 'text', array(
                    'required' => true,
                    'label' => 'Apellido Materno (*):'))
                ->add('nombres', 'text', array(
                    'required' => true,
                    'label' => 'Nombres (*):'))
                ->add('diploma', 'text', array(
                    'required' => false,
                    'label' => 'Diploma:'))
                ->add('titulo', 'text', array(
                    'required' => false,
                    'label' => 'Título:'));
    }

    /**
     * @param OptionsResolverInterface $resolver
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver) {
        $resolver->setDefaults(array(
            'data_class' => 'Cidetsi\DocentesBundle\Entity\Docente'
        ));
    }

    /**
     * @return string
     */
    public function getName() {
        return 'docente';
    }
}

