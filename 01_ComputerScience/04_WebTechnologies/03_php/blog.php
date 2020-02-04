<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <!-- Wersja XHTML-->

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Komentarz</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
		charset=UTF-8" /> <!-- Kodowanie dokumentu -->
	</head>
	<body>
        <div>
            <?php
                include('menu.php');

                $blogNazwa = $_GET['nazwa'];

                if(is_dir($blogNazwa)){


                    foreach ( new DirectoryIterator($blogNazwa) as $fileInfo ) {
                        if($fileInfo->isDot()) continue;
                        if($fileInfo->isDir()) continue;

                        $nazwaPliku = $fileInfo->getFilename();
                        $dlugosc = strlen($nazwaPliku);
                        if($dlugosc == 16){
        
                            $wpisTresc = file_get_contents($blogNazwa."/".$nazwaPliku);
                            echo "<p style='border-style: solid; width:800px;'>".$wpisTresc."</p>";

                            $zalacznikiWpisu = glob("{$blogNazwa}/{$nazwaPliku}[1-3]*");
                            $liczbaZalacznikow = count($zalacznikiWpisu);

                            // wypisz linki do zalacznikow bloga
                            for ($x = 0; $x < $liczbaZalacznikow; $x++) {
                                $y = $x+1;
                                // echo "Znalacznik nr ".$x.":".$zalacznikiWpisu[$x]."<br/>";
                                echo "
                                <p style='border-style: dashed; width:300px;'>
                                    <a href='".$zalacznikiWpisu[$x]."'>Zalacznik$y</a>
                                </p> 
                                ";
                            }

                            echo  "<a href='"."nowykomentarz.php?nazwabloga=".$blogNazwa."&nazwawpisu=".
                                     $nazwaPliku."'>Dodaj komentarz do wpisu</a>";
                            
                            $komentarzeFolder = $nazwaPliku.".k";

                            if(is_dir($blogNazwa."/".$komentarzeFolder)){
                                
                                foreach ( new DirectoryIterator($blogNazwa."/".$komentarzeFolder) as $plikKom ){

                                    if($plikKom->isDot()) continue;
                                    if($plikKom->isDir()) continue;

                                    $komTresc = file_get_contents($blogNazwa."/".$komentarzeFolder."/".$plikKom);
                                    echo 
                                    "<p style='border-style: dotted; width:600px;'>"
                                        .$komTresc.
                                    "</p>";

                                }

                            }       
                        }

                        echo "<br/><br/><br/>"; 
                    }

                   
                }
                else if($blogNazwa == ""){
                    echo " <p> Wszystkie blogi to:  ";
                    echo "<ul>";
                    foreach ( new DirectoryIterator(dirname(__FILE__)) as $fileInfo ) {
                        if($fileInfo->isDot()) continue;
                        if($fileInfo->isDir()){
                            $blogTemp = $fileInfo->getFilename();

                            echo  "<li>
                                    <a href='"."blog.php?nazwa=".$blogTemp."'>
                                        Blog: ".$blogTemp."
                                    </a>
                                   </li>";
                        }
                    echo "</ul> </p>";
                    }
                }
                else{
                    echo " <p> Nie ma blogu o podanej nazwie </p> ";
                }
            ?>

        </div>
	</body>
</html>