<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <!-- Wersja XHTML-->

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Nowy Wpis</title> <!-- Tytuł z polskimi znakami -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; 
        charset=UTF-8" /> <!-- Kodowanie dokumentu -->
        
        <script>

            var zalacznikNumer = 0;

            function ustawDate(){
                console.log("Ustawiam date");
                var dataTeraz = new Date();
                var dzien = dataTeraz.getDate();
                if(dzien < 10){
                    dzien = "0" + dzien;
                }
                var miesiac = dataTeraz.getMonth()+1; //Styczen to 0!
                if(miesiac < 10){
                    miesiac = "0" + miesiac;
                }
                var rok = dataTeraz.getFullYear();
                var data = rok + "-" + miesiac + "-" + dzien;
                document.getElementsByName('dataWpis')[0].value = data;
            }

            function ustawGodzine(){
                console.log("Ustawiam godzine");
                var godzinaTeraz = new Date();
                var godzina = godzinaTeraz.getHours();
                if(godzina < 10){
                    godzina = "0" + godzina;
                }
                var minuta = godzinaTeraz.getMinutes(); 
                if(minuta < 10){
                    minuta = "0" + minuta;
                }
                var godzina = godzina + ":" + minuta;
                document.getElementsByName('godzinaWpis')[0].value = godzina;
            }

            function sprawdzDate(){
                console.log("Sprawdzam date");
                var wzorDaty = /^[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]$/;
                var dataWpisu =  document.getElementsByName('dataWpis')[0].value;
                if(wzorDaty.test(dataWpisu)){
                    console.log("Poprawny format daty");
                    var rok = dataWpisu.substr(0,4);
                    var miesiac = dataWpisu.substr(5,2);
                    var dzien = dataWpisu.substr(8,2);
                    if( miesiac[0] == 0 ){
                        miesiac = miesiac[1];
                    }
                    if( dzien[0] == 0 ){
                        dzien = dzien[1];
                    }
                    miesiac = miesiac - 1;
                    console.log("Rok to " + rok);
                    console.log("Miesiac to " + miesiac);
                    console.log("Dzien to " + dzien);
                    var dataTest = new Date(rok, miesiac, dzien);
                    console.log("dataTest to " + dataTest);
                    if(dataTest.getFullYear() == rok && dataTest.getMonth() == miesiac && dataTest.getDate() == dzien){
                        console.log("Poprawna data");
                    }
                    else{
                        console.log("Niepoprawna data");
                        ustawDate();
                    }
                }   
                else{
                    console.log("Zly format daty");
                    ustawDate();
                }
            }


            function sprawdzGodzine(){
                console.log("Sprawdzam godzine");
                var wzorGodziny = /^[0-2][0-9]:[0-5][0-9]$/;
                var godzinaWpisu =  document.getElementsByName('godzinaWpis')[0].value;
                if(wzorGodziny.test(godzinaWpisu)){
                    console.log("Poprawny format godziny");
                    var godzina = godzinaWpisu.substr(0,2);
                    var minuta = godzinaWpisu.substr(3,2);
                    if( godzina[0] == 2 && godzina[1] > 3 ){
                        console.log("Niepoprawna godzina");
                        ustawGodzine();
                    }
                    else{
                        console.log("Poprawna godzina");
                    }
                }   
                else{
                    console.log("Zly format godziny");
                    ustawGodzine();
                }
            }

            function dodajPlik(){
                zalacznikNumer = zalacznikNumer + 1;
                console.log("Dodaj plik nacisniety");
                nowy = document.createElement('input');
                nowy.type = 'file';
                nowy.name = 'zalacznikWpis' + zalacznikNumer;
                document.getElementById('pliki').appendChild(nowy);
            }

        </script>

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
                        <input type="text" name="dataWpis" onBlur="sprawdzDate()"/><br/>

                         <script>
                            ustawDate();
                        </script>
                   
                        Godzina:<br/>
                        <input type="text" name="godzinaWpis" onBlur="sprawdzGodzine()"/><br/>

                        <script>
                            ustawGodzine();
                        </script>
                   

                        <fieldset id="pliki">
                      
                        </fieldset>

                        <input type="submit" value="Wyślij"/>
                        <input type="reset" value="Wyczyść"/>
                    </p>
                
                </form>
        
                <button type="button" onClick="dodajPlik()">Dodaj plik</button> 
                
		</div>

	</body>
</html>