<?php

namespace Cidetsi\BaseBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction() {
        $items = array(
            'departamento' => array(
                'label' => 'Departamentos',
                'description' =>
                    'Lista de los diferentes departamentos en la FCyT',
            ),
            'carrera' => array(
                'label' => 'Carreras',
                'description' =>
                    'Lista de las diferentes carreras que comprenden la FCyT',
            ),
            'materia' => array(
                'label' => 'Materias',
                'description' =>
                    'Lista de las diferentes materias que son dictadas en la FCyT',
            ),
            'docente' => array(
                'label' => 'Docentes',
                'description' =>
                    'Lista de todo el personal docente que compone la FCyT',
            ),
            'gestion' => array(
                'label' => 'Gestiones',
                'description' =>
                    'Lista de las diferentes gestiones registradas en la FCyT',
            ),
        );

        return $this->render('CidetsiBaseBundle:Default:index.html.twig', array(
            'items' => $items,
        ));
    }

    public function menuAction() {
        return $this->render('CidetsiBaseBundle:Default:menu.html.twig');
    }

    public function toolbarAction() {
        return $this->render('CidetsiBaseBundle:Default:toolbar.html.twig');
    }

    public function footerAction() {
        return $this->render('CidetsiBaseBundle:Default:footer.html.twig');
    }

    public function cleanAction() {
        $path = __DIR__ . '/../../../../';
        $path = realpath($path);
        $path = $path . '/app/cache/';
        $this->removeDir($path . 'prod/');
        $this->removeDir($path . 'dev/');
        return $this->render('CidetsiBaseBundle:Default:clean.html.twig');
    }

    private function removeDir($dir) {
        if ($handle = opendir($dir)) {
            $array = array();
            while (false !== ($file = readdir($handle))) {
                if ($file != '.' && $file != '..') {
                    if (is_dir($dir . $file)) {
                        if (!@rmdir($dir . $file)) {
                            $this->removeDir($dir . $file . '/');
                        }
                    } else {
                        @unlink($dir . $file);
                    }
                }
            }
            closedir($handle);
            @rmdir($dir);
        }
    }
}

