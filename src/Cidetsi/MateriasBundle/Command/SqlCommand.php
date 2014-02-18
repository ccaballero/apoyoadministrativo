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

        $materias = array();
        $buffer = array();
        $malla_curricular = array();
        $prerequesitos = array();
        
        foreach($planes as $plan => $materias) {
            foreach ($materias as $materia => $_materia) {
                if (array_key_exists($materia, $dict2)) {
                    $i = $dict2[$materia];
                    if (array_key_exists($i, $buffer)) {
                        $seq = $buffer['ident'];
                        $dpto = $buffer['departamento'];
                    }
                }

                $seq = $this->start_sequence++;
                $dpto = array_key_exists($materia, $dict1) ?
                    $dict1[$materia] : 1;

                $materias[] = array(
                    'ident' => $seq,
                    'departamento' => $dpto,
                );

                $malla_curricular[] = array(
                    'departamento' => $dict3[$plan]['departamento'],
                    'carrera' => $dict3[$plan]['carrera'],
                    'plan' => $dict3[$plan]['ident'],
                    'departamento2' => $dpto,
                    'materia' => $seq,
                    'name' => $_materia['name'],
                    'code' => $materia,
                    'type' => $_materia['type'] == ' ' ? 'C':'NC',
                    'level' => $_materia['level'],
                );
            }
        }
        

/*        $materias = $this->getData();
        ksort($materias);

        if (!empty($filename)) {
            $in_array = array();
            foreach ($materias as $code => $materia) {
                $in_array[] = $code;
            }

            $sql = 'INSERT INTO `materia` '
                 . '(`ident`,`departamento`,`name`,`code`)'
                 . PHP_EOL . 'VALUES' . PHP_EOL;

            $values = array();
            $start = $this->start_sequence;
            foreach ($materias as $code => $materia) {
                $dpto = 1;
                if (array_key_exists($code, $materia_departamento)) {
                    $dpto = $materia_departamento[$code];
                }

                $values[] = $start++ . ','
                          . $dpto . ',\''
                          . iconv('ISO-8859-1', 'UTF-8', $materia['name']) . '\',\''
                          . $code . '\'';
            }

            $sql .= '(' . implode("),\n(", $values) . ');' . PHP_EOL;
            $output->writeln('registrando salida en: ' . $filename);
            file_put_contents($filename, $sql);
        } else {
            $output->writeln('Generando lista ... ');
            $output->writeln('');

            foreach ($materias as $code => $materia) {
                $dpto = 0;
                if (array_key_exists($code, $materia_departamento)) {
                    $dpto = $materia_departamento[$code];
                }
                $output->writeln($dpto . ' ' . $code . ' ' . $materia['name']);
            }
        }*/
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
        $return = array();

        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                preg_match($regex, $line, $matches);

                $return[$matches['code']] = array(
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

        return $return;
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

