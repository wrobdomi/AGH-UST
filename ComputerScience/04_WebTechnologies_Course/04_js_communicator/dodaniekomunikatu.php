<?php
   
    $blog = $_POST['blog'];
    $user = $_POST['user'];
    $tekst = $_POST['tekst'];

    $pliknazwa = $blog."kom";

    $plik=file($pliknazwa);
    $linie = count($plik);
    $plikkom = fopen($pliknazwa, "a");
    $tekstDoZapisu = $user.": ".$tekst."\r\n";

    if($linie > 100){
        $komTresc = file_get_contents($pliknazwa);
        $nowaTresc = substr($komTresc, strrpos($komTresc, "\r\n"), strlen($komTresc)-1 );
        $nowaTresc = $nowaTresc.$tekstDoZapisu;
        fwrite($plikkom, $tekstDoZapisu);
    }else{
        fwrite($plikkom, $tekstDoZapisu);
    }
    
    fclose($plikkom);
    
?>

