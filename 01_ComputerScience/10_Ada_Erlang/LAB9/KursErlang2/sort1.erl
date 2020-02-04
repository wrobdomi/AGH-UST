%  sort1.erl
-module(sort1).
-compile([export_all]).

get_mstimestamp() ->
  {Mega, Sec, Micro} = os:timestamp(),
  (Mega*1000000 + Sec)*1000 + round(Micro/1000).


sendSortRequest() ->
  io:format("Odebralem liste: "),
  receive 						% odbior
	{Od, Lw} -> 
		io:fwrite("~w~n",[Lw]),
		sendPart(Lw)
  end.	



sendPart([]) -> 
 io:format("Koniec listy do wysylania");

sendPart([A,B|T]) ->
  io:format("Wysylam czesc listy: "),
  Id = spawn(?MODULE, sortPart, []),
  Id!{self(),[A,B]},
  sendPart(T).


sortPart() -> 
  io:format("Sorting part: "),
  receive 						% odbior
	{Od, Part} -> io:fwrite("~w~n",[Part]),
	Wyn = sorts(Part),
	Od!{self(), Wyn},
	io:fwrite("~w~n",[Wyn])
  end.	




  
sorts(L) -> lists:foldl(fun insert/2, [], L).
 
insert(X,[]) -> [X];
insert(X,L=[H|_]) when X =< H -> [X|L];
insert(X,[H|T]) -> [H|insert(X, T)].

sortw(L) -> 
  % dopisz sortowanie współbieżne liste L
  timer:sleep(200),
  L.  

gensort() ->
 L=[rand:uniform(20)+1 || _ <- lists:seq(1, 16)],	
 Lw=L,
 io:format("Liczba elementów = ~p ~n",[length(L)]),
 io:fwrite("~w~n",[L]),
 
 io:format("Sortuję sekwencyjnie~n"),	
 TS1=get_mstimestamp(),
 Lr = sorts(L),
 DS=get_mstimestamp()-TS1,	
 io:format("Czas sortowania ~p [ms]~n",[DS]),
 io:fwrite("~w~n",[Lr]),
 
 
 
 
 io:format("Sortuję współbieżnie~n"),	
 

 
 TS2=get_mstimestamp(),
 
 
 SendSortRequestId = spawn(?MODULE, sendSortRequest, []),
 SendSortRequestId!{self(),Lw}.
 
 % sortw(Lw),
 % DS2=get_mstimestamp()-TS2,	
 % io:format("Czas sortowania ~p [ms]~n",[DS2]).
 
 