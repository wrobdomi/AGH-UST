var stop = 1;

// inicjalizacja polaczenia z serwerem
function wlacz( blognazwa ) {
    var startKom = document.getElementById("komunikator");
    if (startKom.checked == true){
        console.log("Wlaczam");
        stop = 0;
        polacz(blognazwa, 'odbierz');
    }
    else{
        stop = 1;
    }
}

function polacz(blognazwa, typ){
    
    var xmlhttp = new XMLHttpRequest();
    console.log("Laczenie typu " + typ);
    if(typ == 'odbierz'){
        xmlhttp.onreadystatechange = odbierzdane;
        xmlhttp.open("GET","odbiorkomunikatow.php?komdata=&blog="+blognazwa,true); 
        // inicjalizacja polaczenia
        xmlhttp.send();
    }
    if(typ == 'wyslij' && stop == 0){
        // xmlhttp.onreadystatechange = wyslijdane;
        var u = document.getElementById("uzytkownikKomunikat").value;
        var t = document.getElementById("nowyKomunikat").value;
        var wiadomosc = "blog=" + blognazwa + "&user=" + u + "&tekst=" + t;
        console.log(wiadomosc);
        xmlhttp.open("POST","dodaniekomunikatu.php",true); 
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        // inicjalizacja polaczenia
        xmlhttp.send(wiadomosc);
        document.getElementById("nowyKomunikat").value = "";
    }
    return false;
}


// odbierz dane i 
// podtrzymaj polaczenie
function odbierzdane(e){

    console.log("Odbieram dane");

    if ( e.target.readyState == 3 && e.target.status == 200 ) {
        var odpowiedz = e.target.responseText;
        var ostatniamod = odpowiedz.substr(0, 13);
        var zawartosc = odpowiedz.slice(odpowiedz.indexOf(" "), odpowiedz.length-1);
        if( stop == 0){
        document.getElementById("komunikaty").innerHTML= zawartosc;
                            // "Data to " + ostatniamod +
                            // " Zawartosc to " + zawartosc; 
        }
    }
    if (e.target.readyState == 4) { // server zamyka polaczenie
        var odpowiedz = e.target.responseText;
        var ostatniamod = odpowiedz.substr(0, 13);
        var blog = odpowiedz.slice(13, odpowiedz.indexOf(" "));
        if(stop == 0){
            e.target.open("GET", "odbiorkomunikatow.php?komdata=" + ostatniamod
                        +"&blog=" + blog, true);
            e.target.send();
        }
    }

}