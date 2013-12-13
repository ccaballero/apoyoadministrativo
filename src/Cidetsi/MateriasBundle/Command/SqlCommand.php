<?php

namespace Cidetsi\MateriasBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

// fetch the list of docentes and registry in the database
class SqlCommand extends ContainerAwareCommand
{
    protected $start_sequence = 100;

    protected function initialize(
            InputInterface $input, OutputInterface $output) {
        parent::initialize($input, $output);
        $this->em = $this->getContainer()
                         ->get('doctrine')->getEntityManager();
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

        $materias = $this->getData();

        if (empty($filename)) {
            $output->writeln('Generando lista ... ');
            $output->writeln('');

            foreach ($materias as $code => $materia) {
                $output->writeln($code . '  ' . $materia['name']);
            }
        } else {
            $sql = 'INSERT INTO `materia` (`ident`, `departamento`,`name`,`code`)'
                 . PHP_EOL . 'VALUES' . PHP_EOL;

            $values = array();
            $start = $this->start_sequence;
            foreach ($materias as $code => $materia) {
                $values[] = $start++ . ',' . $materia['departamento'] . ',\''
                          . $materia['name'] . '\',\'' . $code . '\'';
            }

            $sql .= '(' . implode("),\n(", $values) . ');' . PHP_EOL;
            $output->writeln('registrando salida en: ' . $filename);
            file_put_contents($filename, $sql);
        }
    }

    protected function getScrappingPath() {
        $root = $this->getContainer()->get('kernel')->getRootDir();
        return realpath($root
                . '/../data/implantation/scrapping');
    }

    protected function listFiles() {
        $return = array();

        $dir = $this->getScrappingPath();
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

    protected function getData() {
        $files = $this->listFiles();

        $all = array();

        foreach ($files as $file) {
            $hash = $this->getDataFile($file);
            foreach ($hash as $key => $value) {
                if (!array_key_exists($key, $all)) {
                    $all[$key] = $value;
                }
            }
        }

        return $all;
    }

    protected function getDataFile($file) {
        $regex = '/^(?P<depto>[0-9]) (?P<level>[A-J]) (?P<name>.{50}) (?P<code>\d{7}) (?P<type>[ |x]) {(?P<pres>.*)}$/';

        $handle = @fopen($file, 'r');
        $matches = array();
        $return = array();

        if ($handle) {
            while (($line = fgets($handle, 4096)) !== false) {
                preg_match($regex, $line, $matches);

                $return[$matches['code']] = array(
                    'departamento' => $matches['depto'],
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
}
