<?php

namespace Cidetsi\MateriasBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * SqlCommand: Generador del fichero SQL con la información de las materias, y
 * las mallas curriculares, ademas de sus prerequisitos.
 *
 * Entrada: Directorio con los ficheros de scrapping de todos los planes de 
 * estudio.
 *
 * Salida: Fichero SQL con la insercion de datos en las tablas:
 *     - materia
 *     - malla_curricular
 *     - prerequisito
 */
class SqlCommand extends ContainerAwareCommand
{
    protected $start_sequence = 100;

    protected function initialize(
            InputInterface $input, OutputInterface $output) {
        parent::initialize($input, $output);
        $this->em = $this->getContainer()
                         ->get('doctrine')->getEntityManager();
        $this->root = $this->getContainer()->get('kernel')->getRootDir();
    }

    protected function configure() {
        parent::configure();

        $this->setName('cidetsi:sql:materias')
             ->setDescription('Fetch courses information')
              ->addArgument(
                'filename', InputArgument::OPTIONAL,
                'Filename in the register the sql content');
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        $output->writeln('Procesando la información de materias ... ');

        $filename = $input->getArgument('filename');

        $dict1 = $this->loadDictDepartamentoMateria();
        $dict2 = $this->loadDictMateriaCodigo();
        $dict3 = $this->loadPlanEstudios();

        $planes = $this->getPlanesEstudio();

        $_materias = array();
        $_buffer = array();
        $_malla = array();
        $_prerequesitos = array();
        
        foreach($planes as $p => $materias) {
            foreach ($materias as $m => $materia) {
                if (array_key_exists($m, $dict2)) {
                    $grupo = $dict2[$m];
                    
                    if (array_key_exists($grupo, $_buffer)) {
                        $seq = $_buffer[$grupo]['ident'];
                        $dpto = $_buffer[$grupo]['departamento'];
                    } else {
                        $seq = $this->start_sequence++;
                        $dpto = array_key_exists($m, $dict1) ?
                            $dict1[$m] : 1;

                        $_buffer[$grupo] = array(
                            'ident' => $seq,
                            'departamento' => $dpto,
                        );
                    }
                } else {
                    $seq = $this->start_sequence++;
                    $dpto = array_key_exists($m, $dict1) ?
                        $dict1[$m] : 1;
                }

                $_materias[] = array(
                    'ident' => $seq,
                    'departamento' => $dpto,
                );

                $_malla[] = array(
                    'departamento' => $dict3[$p]['departamento'],
                    'carrera' => $dict3[$p]['carrera'],
                    'plan' => $dict3[$p]['ident'],
                    'departamento2' => $dpto,
                    'materia' => $seq,
                    'name' => $materia['name'],
                    'code' => $m,
                    'type' => $materia['type'] == ' ' ? 'C':'NC',
                    'level' => $materia['level'],
                );
            }
        }
        
        if (!empty($filename)) {
            $values = array();
            foreach ($_malla as $i) {
                $values[] =
                      str_pad($i['departamento'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['carrera'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['plan'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['departamento2'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['materia'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad('\'' . iconv('ISO-8859-1', 'UTF-8', $i['name'])
                        . '\'', 50, ' ', STR_PAD_LEFT) . ', '
                    . str_pad('\'' . $i['code'] . '\'', 3, ' ', STR_PAD_LEFT)
                        . ', '
                    . str_pad('\'' . $i['type'] . '\'', 3, ' ', STR_PAD_LEFT)
                        . ', '
                    . ('\'' . $i['level'] . '\'');
            }

            $sql = 'INSERT INTO `materia` '
                 . '(`ident`,`departamento`,`name`,`code`)'
                 . PHP_EOL . 'VALUES' . PHP_EOL;

//  . iconv('ISO-8859-1', 'UTF-8', $materia['name']) . '\',\''

            $sql .= '(' . implode("),\n(", $values) . ');' . PHP_EOL;
            $output->writeln('registrando salida en: ' . $filename);
            $output->writeln($sql);
            file_put_contents($filename, $sql);
        } else {
            $output->writeln('Generando lista ... ');
            $output->writeln('');

            foreach ($_malla as $i) {
                $output->writeln(
                      str_pad($i['departamento'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['carrera'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['plan'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['departamento2'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['materia'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['name'], 50, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['code'], 3, ' ', STR_PAD_LEFT) . ', '
                    . str_pad($i['type'], 3, ' ', STR_PAD_LEFT) . ', '
                    . $i['level']);
            }
        }
    }

    protected function loadDictDepartamentoMateria() {
        $dict = array();
        $path = realpath($this->root
              . '/../data/implantation/dicts/aux-departamento-materia.txt');

        $handle = @fopen($path, 'r');
        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                list($materia, $departamento) = explode(' ', $line);
                $dict[$materia] = trim($departamento);
            }
            if (!feof($handle)) {
                echo 'Error: unexpected fgets() fail' . PHP_EOL;
            }
            fclose($handle);
        }

        return $dict;
    }

    protected function loadDictMateriaCodigo() {
        $dict = array();
        $path = realpath($this->root
              . '/../data/implantation/dicts/aux-materia-codigo.txt');

        $handle = @fopen($path, 'r');
        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                list($i, $materias) = explode('    ', $line);
                $_materias = explode(' ', $materias);
                $_i = intval($i);

                foreach ($_materias as $_materia) {
                    $_materia = trim($_materia);
                    $dict[$_materia] = $_i;
                }
            }
            if (!feof($handle)) {
                echo 'Error: unexpected fgets() fail' . PHP_EOL;
            }
            fclose($handle);
        }

        return $dict;
    }

    protected function loadPlanEstudios() {
        $dict = array();
        $path = realpath($this->root
              . '/../data/implantation/dicts/aux-planestudio.txt');

        $handle = @fopen($path, 'r');
        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                $keys = explode('  ', $line);
                $dict[trim($keys[3])] = array(
                    'ident' => trim($keys[0]),
                    'departamento' => trim($keys[1]),
                    'carrera' => trim($keys[2]),
                );
            }
            if (!feof($handle)) {
                echo 'Error: unexpected fgets() fail' . PHP_EOL;
            }
            fclose($handle);
        }

        return $dict;
    }

    protected function getPlanesEstudio() {
        $path = realpath($this->root
              . '/../data/implantation/scrapping');

        $files = $this->listFiles($path);

        $planes = array();
        foreach ($files as $file) {
            $plan = basename($file, '.txt');
            $planes[$plan] = $this->getMallaCurricular($file);
        }

        return $planes;
    }

    protected function getMallaCurricular($file) {
        $regex = '/^(?P<level>[A-J]) (?P<name>.*) '
                . '(?P<code>\d{7}) (?P<type>[ |x]) {(?P<pres>.*)}$/';

        $handle = @fopen($file, 'r');
        $matches = array();
        $materias = array();

        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                preg_match($regex, $line, $matches);

                $materias[$matches['code']] = array(
                    'name' => trim($matches['name']),
                    'level' => $matches['level'],
                    'type' => $matches['type'],
                    'pres' => explode(',', $matches['pres']),
                );
            }
            if (!feof($handle)) {
                echo 'Error: unexpected fgets() fail' . PHP_EOL;
            }
            fclose($handle);
        }

        return $materias;
    }

    protected function listFiles($dir) {
        $return = array();
        $files = scandir($dir);
        if ($files) {
            foreach ($files as $file) {
                $_file = $dir . '/' . $file;
                if (is_file($_file)) {
                    $return[] = $_file;
                }
            }
        }
        return $return;
    }
}

