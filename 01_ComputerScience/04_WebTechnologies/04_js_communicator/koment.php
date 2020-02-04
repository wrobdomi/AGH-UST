<?php

    // echo "Blog to: ".$_POST['nazwaBloga'];
    // echo "Wpis to: ".$_POST['nazwaWpisu'];
    include('menu.php');
    
    $wpisNazwa = $_POST['nazwaWpisu'];
    $blogNazwa = $_POST['nazwaBloga'];

    $rodzajKomentarza = $_POST['komentarzRodzaj'];
    $trescKomentarza = $_POST['komentarzOpis'];
    $psudonimKomentujacego = $_POST['uzytkownikNazwaKomentarz'];
    $cs = getdate();
    $dataKomentarza = $cs['year']."-".$cs['mon']."-".$cs['mday']." ".$cs['hours'].":".$cs['minutes'].":".$cs['seconds'];

    // echo "Rodzaj komentarza to ".$rodzajKomentarza;
    // echo "Tresc komentarza to ".$trescKomentarza;
    // echo "Pseudo uzytkownika to ".$psudonimKomentujacego;
    // echo "Data komentarza to ".$dataKomentarza;

    $folderKomentarz = $wpisNazwa.".k";

    // echo "folder komentarza to ".$folderKomentarz;

    // -- -- Sekcja krytyczna -- -- //
    define(KLUCZ, 123321);
    $sem = sem_get(KLUCZ);
    ob_flush(); flush();
    sem_acquire($sem);

    if(!is_dir($blogNazwa."\\".$folderKomentarz)){
        // jeżeli nie istnieje jeszcze żaden komentarz do wpisu
        if(mkdir($blogNazwa."\\".$folderKomentarz)){

            $max = 0;
            $nazwaNowego = $max;
            echo "Nazwa nowego pliku to ".$nazwaNowego;

            // NA LINUKSIE SCIEZKA W DRUGA STRONE SLASH
            $plikKomentarza = fopen($blogNazwa."\\".$folderKomentarz."\\".$nazwaNowego, "w");

            $tekstDoZapisu = $rodzajKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $dataKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $psudonimKomentujacego."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $trescKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            fclose($plikKomentarza);
        
        }
        else{
            echo "<p> Nie udało się dodać komentarza - nie można stworzyć folderu </p>";
        }
    }else{

            $max = 0;

            foreach ( new DirectoryIterator($blogNazwa."\\".$folderKomentarz) as $fileInfo ) {
                if($fileInfo->isDot()) continue;
                if($fileInfo->isDir()) continue;
                $komentarzTemp = $fileInfo->getFilename();
                if($komentarzTemp > $max){
                    $max = $komentarzTemp;
                }
            }

            // echo "max is ".$max;
            $nazwaNowego = $max+1;
            // echo "Nazwa nowego pliku to ".$nazwaNowego;

            // NA LINUKSIE SCIEZKA W DRUGA STRONE SLASH
            $plikKomentarza = fopen($blogNazwa."\\".$folderKomentarz."\\".$nazwaNowego, "w");

            $tekstDoZapisu = $rodzajKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $dataKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $psudonimKomentujacego."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            $tekstDoZapisu = $trescKomentarza."\r\n";
            fwrite($plikKomentarza, $tekstDoZapisu);

            fclose($plikKomentarza);
    }
    
    ob_flush(); flush();
    sem_release($sem);
    // -- -- Wyjscie z sekcji krytycznej -- -- // 

?>