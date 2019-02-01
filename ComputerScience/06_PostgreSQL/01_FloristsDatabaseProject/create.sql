-- Dominik Wrobel
-- dwrobel@student.agh.edu.pl
begin;

create table kwiaty (
	idkwiatu 		char(4) primary key, 		
	nazwa			varchar(50) not null unique, -- nazwa musi byc unikalna aby nie dodac kwiatu dwa razy
	rodzaj 			varchar(50) not null, -- kazdy kwiat musi miec rodzaj np. tulipan
	kolor			varchar(20), 
	pochodzenie		varchar(20),
	opis			varchar(100),
	cena			numeric(4,2) not null check( cena > 0 ), -- kazdy kwiat musi miec cene wieksza od zera
	dostepne  		integer check( dostepne >= 0 ) -- dostepnosc 0 oznacza brak
);

create table dekoracje (
	iddekoracji 	char(4) primary key,
	nazwa			varchar(40) not null unique, -- nazwa musi byc unikalna aby nie dodac dekroacji dwa razy
	cena      		numeric(5,2) check( cena > 0 ), -- kazdy kwiat musi miec cene wieksza od zera
	dostepne  		integer check( dostepne >= 0 ) -- dostepnosc 0 oznacza brak
);

create table bukiety (
	idbukietu 	char(4) primary key,
	nazwa     	varchar(40) not null unique,  -- nazwa musi byc unikalna aby nie dodac dekroacji dwa razy
	cena      	numeric(5,2) not null check( cena > 0 ), -- kazdy kwiat musi miec cene wieksza od zera
	opis      	varchar(150),
	dostepne  	integer not null check( dostepne >= 0 ) -- dostepnosc 0 oznacza brak
);

create table skladowe (
	idbukietu    char(4) not null references bukiety, -- w join table konieczne sa dwa klucze
	idkwiatu 	 char(4) not null references kwiaty, -- w join table konieczne sa dwa klucze
	sztuk        integer not null, -- konieczne jest podanie ilosci kwiatow w bukiecie
	primary key (idbukietu, idkwiatu)
);

create table dodatki (
	idbukietu  char(4) not null references bukiety, -- w join table konieczne sa dwa klucze
	iddekoracji  char(4) not null references dekoracje, -- w join table konieczne sa dwa klucze
	sztuk        integer not null, -- konieczne jest podanie ilosci dekoracji w bukiecie
	primary key (idbukietu , iddekoracji)
);

create table klienci (
  idklienta   	integer primary key,
  nazwa       	varchar(130) not null unique, -- nazwa musi byc unikalna aby nie dodac dekroacji dwa razy
  ulica       	varchar(30) not null, -- dane kontakotowe sa wymagane przy zamowieniu 
  miejscowosc 	varchar(15) not null,
  email 	  	varchar(40) not null,
  telefon     	varchar(20) not null,
  indywidualny	boolean not null 
);

create table zlecenia (
  idzlecenia   	 integer primary key,
  idklienta      integer not null references klienci,
  datazlecenia   date not null -- kazde zlecenie musi miec przyporzadkowana date
);

create table kompozycje(
  idzlecenia   integer not null references zlecenia, -- w join table konieczne sa dwa klucze
  idbukietu    char(4) not null references bukiety, -- w join table konieczne sa dwa klucze
  sztuk        integer not null, -- konieczne jest podanie ilosci bukietow w zamowieniu
  primary key (idzlecenia, idbukietu)
);

commit;

