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
                    echo "Nazwa bloga to z GET".$_GET['nazwabloga'];
                    echo "Nazwa wpisu to z GET".$_GET['nazwawpisu'];
                ?>
            
                <form action="koment.php" method="post" >
                    
                    <p>
                        Imie/Nazwisko/Pseudonim: <br/>
                        <input type="text" name="uzytkownikNazwaKomentarz"/><br/>
                    
                        Rodzaj komentarza: <br/>
                        <select name="komentarzRodzaj">
                            <option value="pozytywny">Pozytywny</option>
                            <option value="negatywny">Negatywny</option>
                            <option value="neutralny">Neutralny</option>
                        </select>
                    
                        Komentarz: <br/>
                        <textarea name="komentarzOpis" rows="20" cols="60">
                        </textarea> <br/>
                    

                        <input type="hidden" name="nazwaBloga" 
                            value="<?php echo $_GET['nazwabloga'] ?>"/>
                        <input type="hidden" name="nazwaWpisu" 
                            value="<?php echo $_GET['nazwawpisu'] ?>"/>

                        <input type="submit" value="Wyślij"/>
                        <input type="reset" value="Wyczyść"/>
                    

                    </p>
                
                </form>
        
		</div>

	</body>
</html>