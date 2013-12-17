<?php

namespace Cidetsi\DocentesBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
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

        $this->setName('cidetsi:sql:docentes')
             ->setDescription('Fetch teachers information')
             ->addArgument(
                'params', InputArgument::REQUIRED,
                'Connection parameters in .pgpass style')
             ->addArgument(
                'filename', InputArgument::OPTIONAL,
                'Filename in the register the sql content');
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        $filename = $input->getArgument('filename');
        $params = $input->getArgument('params');

        list($host, $port, $database, $user, $pass) = explode(':', $params);

        $output->writeln('Conectando a la base de datos ... ' . $database);
        $dbconn = pg_connect(
            "host=$host dbname=$database user=$user password=$pass") or
            die('No se puede conectar a la base de datos');

        $output->writeln('Extrayendo la información de los docentes ... ');
        $query =
            'SELECT codigo, ci, ape_paterno, ape_materno, nombre,'
                . ' titulo, diploma FROM docente '
                . 'ORDER BY ape_paterno, ape_materno, nombre';
        $result = pg_query($query);

        if (!empty($filename)) {
            $sql = 'INSERT INTO `docente` '
                 . '(`ident`,`ci`,`apellido_paterno`,`apellido_materno`,'
                 . '`nombres`,`diploma`,`titulo`,`pg_id`)' . PHP_EOL
                 . 'VALUES' . PHP_EOL;

            $values = array();
            $start = $this->start_sequence;
            while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
                $values[] = $start++ . ',' . (empty($line['ci']) ? 'null' : '\''
                            . iconv('ISO-8859-1', 'UTF-8', $line['ci'])
                            . '\'') . ',\''
                          . iconv('ISO-8859-1', 'UTF-8', $line['ape_paterno'])
                          . '\',\''
                          . iconv('ISO-8859-1', 'UTF-8', $line['ape_materno'])
                          . '\',\''
                          . iconv('ISO-8859-1', 'UTF-8', $line['nombre'])
                          . '\',\''
                          . iconv('ISO-8859-1', 'UTF-8', $line['diploma'])
                          . '\',\''
                          . iconv('ISO-8859-1', 'UTF-8', trim($line['titulo']))
                          . '\',\''
                          . iconv('ISO-8859-1', 'UTF-8', $line['codigo'])
                          . '\'';
            }
            $sql .= '(' . implode("),\n(", $values) . ');' . PHP_EOL;

            $filename = $input->getArgument('filename');

            if (!empty($filename)) {
                $output->writeln('registrando salida en: ' . $filename);
                file_put_contents($filename, $sql);
            } else {
                $output->writeln($sql);
            }
        } else {
            $output->writeln('Generando lista ... ');
            $output->writeln('');

            while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
                $string = str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['codigo']), 10)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['ci']), 13)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['ape_paterno']), 14)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['ape_materno']), 14)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['nombre']), 20)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['titulo']), 25)
                        . str_pad(iconv('ISO-8859-1', 'UTF-8',
                            $line['diploma']), 25);
                $output->writeln($string);
            }
        }

        pg_free_result($result);
        pg_close($dbconn);
    }
}
