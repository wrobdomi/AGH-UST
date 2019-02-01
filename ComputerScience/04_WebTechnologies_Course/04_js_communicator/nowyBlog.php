<?xml version="1.0"?> <!-- Wersja XML -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <!-- Wersja XHTML-->

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Blog</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
		charset=UTF-8" /> <!-- Kodowanie dokumentu -->
	</head>
	<body>

		<div>	

                <?php include('menu.php'); ?>

                <form action="nowy.php" method="post">
                    
                    <p>
                        Nazwa blogu:<br/>
                        <input type="text" name="blogNazwa" /><br/>
                    
                        Nazwa użytkownika:<br/>
                        <input type="text" name="uzytkownikNazwa"/><br/>
                    
                        Hasło: <br/>
                        <input type="password" name="uzytkownikHaslo"/><br/>
                    
                        Opis blogu:<br/>
                        <textarea name="blogOpis" rows="20" cols="60">
                        </textarea><br/>
                    
                        <input type="submit" value="Wyślij"/>
                        <input type="reset" value="Wyczyść"/>
                    </p>
                
                </form>
        
		</div>

	

	</body>
</html>