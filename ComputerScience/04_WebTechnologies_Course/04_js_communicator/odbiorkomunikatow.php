<?php
   
    $blog = $_GET['blog'];
    $dataklienta = $_GET['komdata'];

    $godzinaklienta = substr($dataklienta, 5, 2);
    $temp = substr($godzinaklienta, 0, 1);
    if( $temp == 0 ){
        $godzinaklienta = substr($godzinaklienta, 1, 1);
    }

    $minutaklienta = substr($dataklienta, 8, 2);
    $temp = substr($minutaklienta, 0, 1);
    if( $temp == 0 ){
        $minutaklienta = substr($minutaklienta, 1, 1);
    }

    $sekundaklienta = substr($dataklienta, 11, 2);
    $temp = substr($sekundaklienta, 0, 1);
    if($temp == 0 ){
        $sekundaklienta = substr($sekundaklienta, 1, 1);
    }

    set_time_limit (45);

    $pliknazwa = $blog."kom";

    $iter = 0;

    while(true){


        if (file_exists($pliknazwa)) {

            clearstatcache();
            $datapliku = date ("Y:H:i:s", filemtime($pliknazwa));
            
            $godzina = substr($datapliku, 5, 2);
            $tempser = substr($godzina, 0, 1);
            if( $tempser == 0 ){
                $godzina = substr($godzina, 1, 1);
            }
            
            $minuta = substr($datapliku, 8, 2);
            $tempser = substr($minuta, 0, 1);
            if( $tempser == 0 ){
                $minuta = substr($minuta, 1, 1);
            }

            $sekunda = substr($datapliku, 11, 2);
            $tempser = substr($sekunda, 0, 1);
            if( $tempser == 0 ){
                $sekunda = substr($sekunda, 1, 1);
            }

            if( 
                ($dataklienta == "") ||
                ($godzinaklienta < $godzina) || 
                ($godzinaklienta <= $godzina && $minutaklienta < $minuta ) ||
                ($godzinaklienta <= $godzina && $minutaklienta <= $minuta && $sekundaklienta < $sekunda )
            ){
                    $komTresc = file_get_contents($pliknazwa);
                    echo date ("Y:H:i:s", filemtime($pliknazwa)).$blog." ".$komTresc;
                    /*." ".$sekundaklienta
                        .$minutaklienta.$godzinaklienta." ".$sekunda.$minuta.$godzina; */
                    break;
            }
            else{
                sleep(1);
                continue;
            }

         }
        else{
        
            sleep(1);
            continue;
           
        }

    }
    

?>

