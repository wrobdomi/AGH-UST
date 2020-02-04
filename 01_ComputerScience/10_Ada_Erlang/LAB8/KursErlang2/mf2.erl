%  mf2.erl
-module(mf2).
-compile([export_all]).

fp()->
  receive 						% odbior
    {Od,agh} -> Od!{agh,ok}		% Wyslij komunikat z powrotem do nadawcy	
  end.							% 
  
fm()->
 FPid=spawn(mf2,fp,[]), % zwraca id watku, np. do wyslania komunikatu
 FPid!{self(),agh}.     % ! to wyslanie komunikatu, po lewej id, po prawej to co wysylamy, self
 					    % zwraca id procesu ktory wysyla, wysylamy krotke dwuelementowa
 
flen(L)->
io:format("flen: ~p ~n",[length(L)]).
  
fm2()->
 Lw=[1,2,3,4,5],
 spawn(mf2,flen,[Lw]).  
 % utworz proces, identyfikator modulu, nazwa funkcji,
 % ktora uruchamiamy (proces), lista argumentow ten funkcji   	
 
 
 % Komunikacja asynchroniczna, gdy odbiorca nie moze odebrac, to przechodzi do bufora