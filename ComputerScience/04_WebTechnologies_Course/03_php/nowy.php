<DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Blog</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
		charset=UTF-8" /> <!-- Kodowanie dokumentu -->
	</head>
	<body>
	<div>

		
	<?php
		
		include('menu.php');

		// PRZYPISYWANIE ZMIENNYM WARTOSCI Z FORMULARZA
		$nazwa = $_POST['blogNazwa'];
		$uzytkownik = $_POST['uzytkownikNazwa'];
		$haslo = $_POST['uzytkownikHaslo'];
		$opis = $_POST['blogOpis'];

		// -- -- Sekcja krytyczna -- -- //
		define(KLUCZ, 123456);
		$sem = sem_get(KLUCZ);
		ob_flush(); flush();
		sem_acquire($sem);

		if(!is_dir($nazwa)){
			if(mkdir($nazwa)){

				// NA LINUKSIE SCIEZKA W DRUGA STRONE SLASH
				$plikbloga = fopen($nazwa."/info", "w");

				$tekstDoZapisu = $uzytkownik."\r\n";
				fwrite($plikbloga, $tekstDoZapisu);

				$tekstDoZapisu = $haslo;
				fwrite($plikbloga, md5($tekstDoZapisu));
				fwrite($plikbloga, "\r\n");

				$tekstDoZapisu = $opis."\r\n";
				fwrite($plikbloga, $tekstDoZapisu);

				fclose($plikbloga);
				
				echo "<p> Blog pomyslnie stworzony </p>";	
			}
			else{
				echo "<p> Nie udało się założyć bloga </p>";
			}
		}else{
			echo "<p> Blog o podanej nazwie już istnieje. </p>";
		}

		ob_flush(); flush();
		sem_release($sem);
		// -- -- Wyjscie z sekcji krytycznej -- -- // 

   	 ?>

	</div>
	</body>
</html> 
