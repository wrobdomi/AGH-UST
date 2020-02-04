% bez uzycia sklej
% ostatni(X,[X]).

%ostatni(Element,[X|Yogon]) :-
%        ostatni(Element,Yogon).


% z uzyciem sklej
ostatni(Element,Lista) :-
	sklej(_,[Element],Lista).


