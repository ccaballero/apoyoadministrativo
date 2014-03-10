<!doctype html>
<html>
    <head>
        <title>CLEANER</title>
    </head>
    <body>
<?php

/* method for clean caches */
class Cleaner
{
    public function removeDir($dir) {
        if ($handle = opendir($dir)) {
            $array = array();
            while (false !== ($file = readdir($handle))) {
                if ($file != '.' && $file != '..') {
                    if (is_dir($dir . $file)) {
                        if (!rmdir($dir . $file)) {
                            $this->removeDir($dir . $file . '/');
                        }
                    } else {
                        echo $dir . $file . ' ... ';
                        echo (unlink($dir . $file)) ? 'true' : 'false';
                        echo '<br />';
                    }
                }
            }
            closedir($handle);
            echo $dir . $file . ' ... ';
            echo (rmdir($dir)) ? 'true' : 'false';
            echo '<br />';
        }
    }
}

$cleaner = new Cleaner();

$path = realpath(__DIR__ . '/../app/cache/dev/') . '/';
echo 'REMOVING ' . $path . '<br />';
$cleaner->removeDir($path);

$path = realpath(__DIR__ . '/../app/cache/prod/') . '/';
echo 'REMOVING ' . $path . '<br />';
$cleaner->removeDir($path);

echo 'OK';

?>
    </body>
</html>

