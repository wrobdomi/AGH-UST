<DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Wpis</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
		charset=UTF-8" /> <!-- Kodowanie dokumentu -->
	</head>
	<body>

    <?php

        include('menu.php');

	// PRZYPISYWANIE ZMIENNYM WARTOSCI Z FORMULARZA, DODAĆ POZOSTAŁE POLA
	$uzytkownik = $_POST['uzytkownikNazwaWpis'];
        $haslo = $_POST['uzytkownikHasloWpis'];
        $haslo = md5($haslo);
        $opis = $_POST['wpisOpis'];
        $data = $_POST['dataWpis'];
        $godzina = $_POST['godzinaWpis'];


        // var_dump($_FILES);

        // echo "Data z formularza to ".$data;
        // echo "Godzina z formularza to ".$godzina;

        $dataParser = DateTime::createFromFormat("Y-m-d", $data);
        $godzinaParser = DateTime::createFromFormat("H:i", $godzina);
        $rok = $dataParser->format("Y");
        $miesiac = $dataParser->format("m");
        $dzien = $dataParser->format("d");
        $godzina = $godzinaParser->format("H");
        $minuta = $godzinaParser->format("i");
        $sekundy = time();
        $sekundy = $sekundy % 60;
        if($sekundy < 10 ){
            $sekundy = "0".$sekundy;
        }
        // $sekundy = 40;
        $unikalnyNumer = "01";
        $plikWpisBaza = $rok.$miesiac.$dzien.$godzina.$minuta.$sekundy;
        $plikWpisNazwa = $rok.$miesiac.$dzien.$godzina.$minuta.$sekundy.$unikalnyNumer;

       // echo "Poczatkowa nazwa pliku to ".$plikWpisNazwa;


        $sciezkaJeden = $_FILES['zalacznikWpisJeden']['name'];
        $sciezkaDwa = $_FILES['zalacznikWpisDwa']['name'];
        $sciezkaTrzy = $_FILES['zalacznikWpisTrzy']['name'];
        $rozszerzenieJeden = pathinfo($sciezkaJeden, PATHINFO_EXTENSION);
        $rozszerzenieDwa = pathinfo($sciezkaDwa, PATHINFO_EXTENSION);
        $rozszerzenieTrzy = pathinfo($sciezkaTrzy, PATHINFO_EXTENSION);

       // echo "Rozszerzenie pliku 1 to ".$rozszerzenieJeden;
       // echo "Rozszerzenie pliku 2 to ".$rozszerzenieDwa;
       // echo "Rozszerzenie pliku 3 to ".$rozszerzenieTrzy;

        // echo "Rok to ".$rok;
        // echo "Miesiac to ".$miesiac;
        // echo "Dzien to ".$dzien;
        // echo "Godzina to ".$godzina;
        // echo "Minuta to ".$minuta;
        // echo "Sekunda to ".$sekundy

        // $test1 = "dominik";
        // $test2 = "4bd2b007716888ed6bf6c2399a6d7305";
        // if($test1 == $uzytkownik && $test2 == $haslo){
        //     echo "COSTAM";
        // }

        $katalogBloga = "";
        

        // znajdz folder bloga uzytkownika
        foreach (new DirectoryIterator(dirname(__FILE__)) as $fileInfo) {
            if($fileInfo->isDot()) continue;
            if(!$fileInfo->isDir()) continue;
            $katalogTemp = $fileInfo->getFilename();
            $plikbloga = fopen($katalogTemp."/info", "r");
            $uzytkownikTemp = fgets($plikbloga);
            $uzytkownikTemp = rtrim($uzytkownikTemp, "\n\r");
            $hasloTemp = fgets($plikbloga);
            $hasloTemp = rtrim($hasloTemp, "\n\r");
            fclose($plikbloga);
        	
	    
	    // if($test1 == $uzytkownikTemp){
            //     echo "COSTAM";
            // }

            if( $uzytkownikTemp == $uzytkownik && $hasloTemp == $haslo ){
                // echo "Znalazlem dopasowanie";
                $katalogBloga = $fileInfo->getFilename();
                break;
            }
            // echo "Czytam z pliku ".$uzytkownikTemp." ".$hasloTemp."\n\r";
        }


        // jesli znaleziono blog, stworz nowy plik w katalogu blogu
        if( $katalogBloga == ""){
            echo "Błędny login lub hasło";
        }else {


            // echo "Nazwa bloga tego uzytkownika to ".$katalogBloga;
            
            // -- -- Sekcja krytyczna -- -- //
            define(KLUCZ, 123123);
            $sem = sem_get(KLUCZ);
            ob_flush(); flush();
            sem_acquire($sem);
        
            $numerWpisu = 1;

            foreach ( new DirectoryIterator($katalogBloga) as $fileInfo ) {
                if($fileInfo->isDot()) continue;
                if($fileInfo->isDir()) continue;
                $wpisTemp = $fileInfo->getFilename();
                if($wpisTemp == $plikWpisNazwa){
                    $numerWpisu = $numerWpisu + 1;
                    if($numerWpisu < 10){
                        $numerWpisu = "0".$numerWpisu;
                    }
                    $plikWpisNazwa = $plikWpisBaza.$numerWpisu;
                }
            }

            if($rozszerzenieJeden == ""){
                $plikZalacznikJeden = $plikWpisNazwa."1";
            }
            else{
                $plikZalacznikJeden = $plikWpisNazwa."1".".".$rozszerzenieJeden;
            }
            if($rozszerzenieDwa == ""){
                $plikZalacznikDwa = $plikWpisNazwa."2";
            }else{
                $plikZalacznikDwa = $plikWpisNazwa."2".".".$rozszerzenieDwa;
            }
            if($rozszerzenieTrzy == ""){
                $plikZalacznikTrzy = $plikWpisNazwa."3";
            }else{
                $plikZalacznikTrzy = $plikWpisNazwa."3".".".$rozszerzenieTrzy;
            }

            $plikbloga = fopen($katalogBloga."/".$plikWpisNazwa, "w");
            move_uploaded_file($_FILES['zalacznikWpisJeden']['tmp_name'], $katalogBloga."/".$plikZalacznikJeden);
            move_uploaded_file($_FILES['zalacznikWpisDwa']['tmp_name'], $katalogBloga."/".$plikZalacznikDwa);
            move_uploaded_file($_FILES['zalacznikWpisTrzy']['tmp_name'], $katalogBloga."/".$plikZalacznikTrzy);
            fwrite($plikbloga, $opis);
            fclose($plikbloga);

	    echo "Wpis zostal dodany";

            ob_flush(); flush();
            sem_release($sem);
            // -- -- Wyjscie z sekcji krytycznej -- -- // 
            
        }
        
        

    ?>


	</body>
</html> 
