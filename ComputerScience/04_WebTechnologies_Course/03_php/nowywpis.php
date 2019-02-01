<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <!-- Wersja XHTML-->

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Wpis</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
		charset=UTF-8" /> <!-- Kodowanie dokumentu -->
	</head>
	<body>

		<div>	

              <?php include('menu.php'); ?>
              
                <form action="wpis.php" method="post" enctype="multipart/form-data">
                    
                    <p>
                        Nazwa użytkownika:<br/>
                        <input type="text" name="uzytkownikNazwaWpis"/><br/>
                    
                        Hasło: <br/>
                        <input type="password" name="uzytkownikHasloWpis"/><br/>
                    
                        Wpis:<br/>
                        <textarea name="wpisOpis" rows="20" cols="60">
                        </textarea><br/>
                    
                        Data:<br/>
                        <input type="text" name="dataWpis" value="<?php echo date('Y-m-d') ?>"/><br/>
                   
                        Godzina:<br/>
                        <input type="text" name="godzinaWpis" value="GG:MM"/><br/>
                   
                        Załącznik 1:<br/>
                        <input type="file" name="zalacznikWpisJeden"/><br/>
                
                        Załącznik 2:<br/>
                        <input type="file" name="zalacznikWpisDwa"/><br/>
                  
                        Załącznik 3:<br/>
                        <input type="file" name="zalacznikWpisTrzy"/><br/>
                   
                        <input type="submit" value="Wyślij"/>
                        <input type="reset" value="Wyczyść"/>
                    </p>
                
                </form>
        
		</div>

	</body>
</html>