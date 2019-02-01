ustawStylCookie();

function pokazStyle(){
    console.log("Cos tam");
    // var links = [];
    var links = document.head.getElementsByTagName("link");
    console.log("Ilosc linkow to " + links.length);

    if(links.length != 0 ){

        var nowyDiv = document.createElement('div');
        nowyDiv.style.cssText = 'width: 500px; margin: auto; text-align: center; color:blue;';
        var nowaLista = document.createElement('ol');
    

        for (i = 0; i < links.length; i++) {
        
            if( (links[i].rel == "stylesheet" || links[i].rel == "alternate stylesheet") && links[i].media == "screen" )  {
                
                var nowyElement = document.createElement('li');
                nowyElement.id = links[i].title;
                nowyElement.onclick = function() { 
                   
                    console.log("ID to " + this.id);
                    var arkusze = document.head.getElementsByTagName("link");
                    for (j = 0; j < arkusze.length; j++) {
                        if( (arkusze[j].rel == "stylesheet" || arkusze[j].rel == "alternate stylesheet") && arkusze[j].media == "screen" ){
                            if(arkusze[j].title == this.id){
                                arkusze[j].disabled = false;
                            }
                            else{
                                arkusze[j].disabled = true;
                                ustawCookie(this.id);
                            }
                        }
                    }   
                };
                nowyElement.innerHTML = "Tytuł: " + links[i].title + " Rel: " + links[i].rel + " Type: " + links[i].type + " Media: " + links[i].media;
                nowaLista.appendChild(nowyElement);

              
                console.log( "Typ to " + links[i].type );
                console.log( "Tytul to " + links[i].title );

            }        
        }
       
        nowyDiv.appendChild(nowaLista);

        document.body.insertBefore(nowyDiv, document.body.firstChild);
    }
}


function ustawCookie(stylUzytkownika){
    document.cookie = "styl=" + stylUzytkownika + ";" + " expires = Thu, 30 Jan 2019 12:00:00 UTC;" ;
}

function ustawStylCookie(){
    var ciastko = document.cookie;
    // console.log(ciastko.substr(0,3));
    // console.log(ciastko);
    if(ciastko != "" && ciastko.substr(0,4) == "styl"){
        var ostatnistyl = ciastko.substring(5, ciastko.indexOf(";"));
        
        var arkusze = document.head.getElementsByTagName("link");
        for (j = 0; j < arkusze.length; j++) {
            if( (arkusze[j].rel == "stylesheet" || arkusze[j].rel == "alternate stylesheet") && arkusze[j].media == "screen" ){
                if(arkusze[j].title == ostatnistyl){
                    arkusze[j].disabled = false;
                }
                else{
                    arkusze[j].disabled = true;
                }
            }
        } 
        
        console.log("Sprawdzam cookie: ")
        console.log(document.cookie);
        console.log(ostatnistyl);

    }
}
