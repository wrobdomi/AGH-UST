%% -*- coding: utf-8 -*-
-module(lab1).
% nazwa modulu

-compile([export_all]).
% opcje kompilatora, w tym wypadku eksport wszystkich funkcji
% przydatne przy testowaniu
%
%-export([add/2, head/1, sum/1] ).
% lista funkcji jakie beda widoczne dla innych modulow

-vsn(1.0).
% wersja

-kto_jest_najlepszy(ja).
%dowolny atom mmoze byc wykorzystany jako 'atrybut' modulu
%po kompilacji uruchom lab1:module_info().
%inne narzedzia moga korzystac z tych informacji


-import(math,[pi/0]).
% lista modulow ,ktore sa potrzebne.
% nie jest to konieczne


%funkcje

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add(a1,a2) -> a1+a2.
add(A1,A2) -> A1+A2.
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
head([H|_]) -> {glowa,H}.
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum([]) -> 0;
sum([H|T]) -> H + sum(T).
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tsum(L) -> tsum(L, 0). %tsum/1

tsum([H|T], S) -> tsum(T, S+H); %tsum/2 
tsum([],S) -> S.
% klauzule funkcji rozdzielana sa srednikiem
% po ostatniej jst kropka
%################################


% Srednia
myMean(A1, A2) -> (A1 + A2) / 2.

% Silnia rekurencyjnie
powerRec(0) -> 1;
powerRec(N) -> N * powerRec(N-1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obwod_kola(Promien) -> 
        Dwa_pi = 2 * pi(),  % wyraĹźenie pomocnicze
        Dwa_pi * Promien.   % ostatni element przed '.' lib ';' 
                            % to wynik funkcji
%################################