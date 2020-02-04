%  zad.erl
-module(zad1).
-compile([export_all]).

konsument()->
  receive 						% odbior
    %{Od,agh} -> Od!{agh,ok}		% Wyslij komunikat z powrotem do nadawcy
	{Od, -1} -> io:format("End of stream: ~p ~n",[-1]);
	{Od, Wartosc} -> io:format("Received: ~p ~n",[Wartosc])
  end.							% 
  
posrednik() ->
 receive
	{KonsumentID, Wartosc} -> KonsumentID!{self(), Wartosc}
 end.
 % FPid = spawn(mf2,fp,[]), % zwraca id watku, np. do wyslania komunikatu
 %FPid!{self(),agh}.     % ! to wyslanie komunikatu, po lewej id, po prawej to co wysylamy, self
 					    % zwraca id procesu ktory wysyla, wysylamy krotke dwuelementowa
 
producent(To, Mes) ->
	 
  
main() ->
 Tablica = [1,2,3,4,5],
 
 KonsumentID = spawn(zad1, konsument, []),
 PosrednikID = spawn(zad1, posrednik, []),
 
 PosrednikID!{KonsumentID, 5},
 PosrednikID!{KonsumentID, 2},
 PosrednikID!{KonsumentID, 3}.
   
   
 
   
 % utworz proces, identyfikator modulu, nazwa funkcji,
 % ktora uruchamiamy (proces), lista argumentow ten funkcji   	
 
 
 % Komunikacja asynchroniczna, gdy odbiorca nie moze odebrac, to przechodzi do bufora