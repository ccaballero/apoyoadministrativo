<?php

namespace Cidetsi\DocentesBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

// fetch the list of docentes and registry in the database
class GrupoSqlCommand extends ContainerAwareCommand
{
    protected function initialize(
            InputInterface $input, OutputInterface $output) {
        parent::initialize($input, $output);
        $this->em = $this->getContainer()
                         ->get('doctrine')->getEntityManager();
    }

    protected function configure() {
        parent::configure();

        $this->setName('cidetsi:sql:grupo-docentes')
             ->setDescription('Fetch courses information')
             ->addArgument(
                'params', InputArgument::REQUIRED,
                'Connection parameters in .pgpass style')
              ->addArgument(
                'filename', InputArgument::OPTIONAL,
                'Filename in the register the sql content');
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        $output->writeln('Procesando la información de materias ... ');
        $filename = $input->getArgument('filename');
        $params = $input->getArgument('params');

        $grupos = $this->getGrupos();
        $docentes = $this->getDocentes();
        
        if (!empty($filename) && !empty($params)) {
            list($host, $port, $database, $user, $pass) = explode(':', $params);

            $output->writeln('Conectando a la base de datos ... ' . $database);
            $dbconn = pg_connect(
                "host=$host dbname=$database user=$user password=$pass") or
                die('No se puede conectar a la base de datos');

            $output->writeln('Extrayendo la información de los materias ... ');
            $query = 'SELECT m.codigo as grupo, d.codigo as docente '
                   . 'FROM materia_dicta m '
                   . 'LEFT JOIN segui_doc s ON m.fk_segui_doc = s.codigo '
                   . 'LEFT JOIN docente d ON s.fk_docente = d.codigo';
            $result = pg_query($query);

            $array = array();
            while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
                $array[] = array(
                    'grupo' => $line['grupo'],
                    'docente' => $line['docente'],
                );
            }

            pg_free_result($result);
            pg_close($dbconn);

            $sql = 'UPDATE grupo SET docente = %s WHERE ident = %s;' . PHP_EOL;

            $values = array();
            foreach ($array as $item) {
                if (isset($grupos[$item['grupo']])
                        && isset($docentes[$item['docente']])) {
                    $values[] = sprintf($sql, $docentes[$item['docente']], $grupos[$item['grupo']]);
                }
            }

            $sql = implode('', $values);
            $output->writeln('registrando salida en: ' . $filename);
            file_put_contents($filename, $sql);
        } else {
            // TODO
        }
    }

    public function getGrupos() {
        $query = $this->em->createQuery(
                'SELECT g FROM \Cidetsi\MateriasBundle\Entity\Grupo g');
        $grupos = $query->getResult();

        $result = array();
        foreach ($grupos as $grupo) {
            $result[$grupo->pg_id] = $grupo->getIdent();
        }

        return $result;
    }

    public function getDocentes() {
        $query = $this->em->createQuery(
                'SELECT d FROM \Cidetsi\DocentesBundle\Entity\Docente d');
        $docentes = $query->getResult();

        $result = array();
        foreach ($docentes as $docente) {
            $result[$docente->pg_id] = $docente->getIdent();
        }

        return $result;
    }
}
