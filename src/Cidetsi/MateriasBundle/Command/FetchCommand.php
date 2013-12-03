<?php

namespace Cidetsi\MateriasBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

use Cidetsi\MateriaBundle\Entity\Materia;

// fetch the list of courses and registry in the database
class FetchCommand extends ContainerAwareCommand
{
    protected function initialize(
            InputInterface $input, OutputInterface $output) {
        parent::initialize($input, $output);
        $this->em = $this->getContainer()
                         ->get('doctrine')->getEntityManager();
    }

    protected function configure() {
        parent::configure();

        $this->setName('cidetsi:scrapping')
             ->setDescription('Fetch courses information')
             ->addArgument(
                'url', InputArgument::REQUIRED,
                'Url from fetch the information')
             ->addOption('db', null, InputOption::VALUE_NONE,
                'If set, the task will insert the information in database');
    }

    protected function execute(InputInterface $input, OutputInterface $output) {
        $url = $input->getArgument('url');
        $html = $this->getPage($url);
        list($plan, $collection) = $this->parse($html);

        $output->writeln('Extrayendo materias de ' . $url);

        if ($input->getOption('db')) {
            // database insertion
            $plan_estudio = $this->em->getRepository(
                'CidetsiDepartamentosBundle:PlanEstudio')
                ->findOneByCode($plan['code']);

            $db_materia = $this->em->getRepository(
                'CidetsiDepartamentosBundle:Materia');

            $materias = array();

            // Filling of basic information
            foreach ($collection as $item) {
                $materia = $db_materia->findOneByCode($item->code);
                if (!$materia) {
                    $materia = new Materia();
                }

                $materia->setName($item->name);
                $materia->setLevel($item->level);
                $materia->setCode($item->code);
                $materia->setType($item->type);

                $materias[$materia->getCode()] = $materia;
            }

            // Filling the prerequisitos
            foreach ($materias as $materia) {
                $pres = $collection[$materia->getCode()]->pre;
                if (!empty($pres)) {
                    foreach ($pres as $pre) {
                        if (array_key_exists($pre, $materia)) {
                            $materia->addPrerequisito($materias[$pre]);
                        }
                    }
                }

                $plan_estudio->addMateria($materia);
                $this->em->persist($materia);
            }

            $this->em->persist($plan_estudio);
            $this->em->flush();
        } else {
            // simple printing
            $output->writeln($plan['name'] . ' (' . $plan['code'] . ')');
            $output->writeln('');

            foreach ($collection as $item) {
                $line = $item->level . ' '
                      . str_pad($item->name, 45) . ' '
                      . $item->code . ' '
                      . ($item->type == 'curricular' ? ' ':'x') . ' '
                      . '{' . implode(',', $item->pre) . '}';

                $output->writeln($line);
            }
            $output->writeln('');
        }
    }

    protected function parse($content) {
        $return = array();

        $lines = explode("\n", $content);
        $matches = array();

        $plan = array(
            'name' => '',
            'code' => '',
        );

        $regex_pname = '/  <TD><FONT SIZE=2><B>Plan de Estudios:<\/B> (?P<name>'
                     . '.*)<\/FONT><\/TD>/';
        preg_match($regex_pname, $content, $matches);
        $plan['name'] = $matches['name'];

        $regex_pcode = '/  <TD><FONT SIZE=2><B>C.digo:<\/B> (?P<code>.*)<\/FONT>'
                     . '<\/TD>/';
        preg_match($regex_pcode, $content, $matches);
        $plan['code'] = $matches['code'];

        foreach ($lines as $i => $line) {
            $regex_code = '/^  <TD><FONT SIZE=1><A HREF="javascript:surfto\(\'u'
                        . 'mss_showSubjContent.asp\?SERVICIO=&subj=(.*)&cyr=\''
                        . '\)" onMouseOver="hideStatusMsg\(\);return true">(?P<'
                        . 'code>.*)<\/A><\/FONT><\/TD>/';
            $regex_level = '/^  <TD ALIGN=center><FONT SIZE=1>(?P<level>.)<\/FO'
                         . 'NT><\/TD>/';
            $regex_name = '/^  <TD><FONT SIZE=1>(?P<name>.*)<\/FONT><\/TD>/';
            $regex_type = '/^  <TD><FONT SIZE=1>(?P<type>&nbsp;|S)<\/FONT><\/TD'
                        . '>/';
            $regex_prereq = '/  (?P<pre>.*)<BR>/';

            $stdClass = new \stdClass();
            if (preg_match($regex_code, $line, $matches)) {
                $stdClass->code = $matches['code'];

                preg_match($regex_level, $lines[$i - 1], $matches);
                $stdClass->level = $matches['level'];

                preg_match($regex_name, $lines[$i + 1], $matches);
                $stdClass->name = $matches['name'];

                preg_match($regex_type, $lines[$i + 2], $matches);
                if ($matches['type'] == 'S') {
                    $stdClass->type = 'no curricular';
                } else {
                    $stdClass->type = 'curricular';
                }

                $count = 5;
                $stdClass->pre = array();
                while (!empty(trim($lines[$i + $count]))) {
                    preg_match($regex_prereq, $lines[$i + $count], $matches);
                    $stdClass->pre[] = $matches['pre'];
                    $count++;
                }

                $return[$stdClass->code] = $stdClass;
            }
        }

        return array($plan, $return);
    }

    protected function getPage($url) {
        // create curl resource
        $ch = curl_init();
        // set url
        curl_setopt($ch, CURLOPT_URL, $url);
        //return the transfer as a string
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // $output contains the output string
        $output = curl_exec($ch);
        // close curl resource to free up system resources
        curl_close($ch);

        return $output;
    }
}
