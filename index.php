<?php
 $data = stream_get_contents(STDIN);
 $json = json_decode($data, true);
 $result = json_encode(array('result' => count($json)));
 echo $result."\n";
?>
