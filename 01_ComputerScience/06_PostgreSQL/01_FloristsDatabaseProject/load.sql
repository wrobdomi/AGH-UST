-- Dominik Wrobel
-- dwrobel@student.agh.edu.pl
insert into klienci values ( 1, 'Jan Kowalski', 'Mickiewicza', 'Krakow', 'jkon@gmail.com', '543950124', true);
insert into klienci values ( 2, 'Sluby S.A.', 'Rynek', 'Warszawa', 'sl@gmail.com', '514650124', false);
insert into klienci values ( 3, 'Grazyna Maczek', 'Armii Krajowej', 'Krakow', 'magraza@o2.pl', '543651124', true);
insert into klienci values ( 4, 'Beauty.pl', 'Sezamkowa', 'Krakow', 'beauty@wp.pl', '543958214', false);
insert into klienci values ( 5, 'Oprawa Uroczystosci sp. z o.o.', 'Bociania', 'Krakow', 'opur@gmail.com', '543120124', false);
insert into klienci values ( 6, 'Michal Sosna', 'Lesnia', 'Krakow', 'sosna@onet.com', '123950124', true);
insert into klienci values ( 7, 'Maria Jedrzejczak', 'Tarnowska', 'Krakow', 'mjed@gmail.com', '548740124', true);
insert into klienci values ( 8, 'Zbigniew Giewont', 'Krokodyli', 'Krakow', 'zbigu@wp.pl', '548170124', true);
insert into klienci values ( 9, 'Lucyna Rodzynek', 'Wiecznej Szczesliwosci', 'Krakow', 'lurydz@gmail.com', '514120124', true);

insert into zlecenia values( 1, 1, '2018-07-14');
insert into zlecenia values( 2, 1, '2018-03-19');
insert into zlecenia values( 3, 2, '2018-12-06');
insert into zlecenia values( 4, 3, '2018-04-01');
insert into zlecenia values( 5, 3, '2018-09-02');
insert into zlecenia values( 6, 3, '2018-12-01');
insert into zlecenia values( 7, 3, '2018-01-01');
insert into zlecenia values( 8, 4, '2018-04-03');
insert into zlecenia values( 9, 4, '2018-08-03');
insert into zlecenia values( 10, 5, '2018-09-19');
insert into zlecenia values( 11, 6, '2018-02-20');
insert into zlecenia values( 12, 7, '2018-03-30');
insert into zlecenia values( 13, 8, '2018-09-09');
insert into zlecenia values( 14, 8, '2018-08-01');
insert into zlecenia values( 15, 8, '2018-02-23');
insert into zlecenia values( 16, 8, '2018-05-21');
insert into zlecenia values( 17, 8, '2018-07-28');
insert into zlecenia values( 18, 8, '2018-03-02');
insert into zlecenia values( 19, 9, '2018-06-18');
insert into zlecenia values( 20, 9, '2018-11-12');
insert into zlecenia values( 21, 9, '2018-01-18');
insert into zlecenia values( 22, 9, '2018-03-18');
insert into zlecenia values( 23, 9, '2018-07-30');

insert into kwiaty values ( 'AA00', 'Mister Lincoln', 'roza', 'czerwony', 'USA', 'Amarantowa pieknosc z silnym aromatem', 7.5, 10);
insert into kwiaty values ( 'AA01', 'Old fragrance', 'roza', 'rozowy', null, 'Mocna pochnaca roza o duzych kwiatach', 10, 5);
insert into kwiaty values ( 'AA02', 'Ena harkness', 'roza', 'rozowy', 'Wielka Brytania', 'Mocny, słodki a jednocześnie owocowy zapach', 5.5, 15);
insert into kwiaty values ( 'AA03', 'Casanova', 'roza', 'zolty', 'Irlandia', 'Intwnsywny zapach, pelne kwiaty', 8.1, 7);
insert into kwiaty values ( 'AA04', 'Papa Meilland', 'roza', 'czerwony', 'Francja', 'Gleboki odcien i mocny zapach', 7.25, 6);
insert into kwiaty values ( 'AA05', 'Crimson Bouquet', 'roza', 'czerwony', 'Niemcy', 'Czerwona roza wielokwiatowa', 7.25, 8);
insert into kwiaty values ( 'AA06', 'Triumph', 'tulipan', 'zolty', null, 'Kwiat z plamkami na brzegach', 4.5, 10);
insert into kwiaty values ( 'AA07', 'Darwin', 'tulipan', 'pomaranczowy', null, 'Duze kwiaty z plomykami na brzegach', 4.5, 5);
insert into kwiaty values ( 'AA08', 'Rembrandt', 'tulipan', 'biale', null, 'Kubkowate kwiaty z paskami o roznych kolorach', 4.5, 5);
insert into kwiaty values ( 'AA09', 'Amarylis', 'amarylis', 'biale', null, 'Wielokwiatowe, z dzwoneczkami w srodku', 5, 10);
insert into kwiaty values ( 'AA10', 'Hiacynt wschodni', 'hiacynt', 'fioletowe', 'Turcja', 'Wielokwiatowe, z dzwoneczkami w srodku', 5, 10);
insert into kwiaty values ( 'AA11', 'Dalia', 'dalia', 'pomaranczowy', null , 'Wielokwiatowe w ksztalcie kuli', 3.6, 15);
insert into kwiaty values ( 'AA12', 'Frezja', 'frezja', 'zolty', 'Afryka', 'Wielokwiatowe z malymi kwiatami w ksztalcie dzwoneczkow', 2.5, 5);
insert into kwiaty values ( 'AA13', 'Gerbera', 'gerbera', 'fioletowy', null, 'Duze kwiaty z dlugimi platkami', 5, 8);

insert into dekoracje values ( 'BB00', 'Wstazka', 4, 0);
insert into dekoracje values ( 'BB01', 'Aksamitka metalizowana', 3, 3);
insert into dekoracje values ( 'BB02', 'Fibra', 2, 10);
insert into dekoracje values ( 'BB03', 'Flizelina', 8, 2);
insert into dekoracje values ( 'BB04', 'Kokarda', 2, 5);
insert into dekoracje values ( 'BB05', 'Koronka', 5, 10);

insert into bukiety values ( 'CC00', 'Kolorowa rewolucja', 56, 'Bukiet w wielu kolorach', 10 );
insert into bukiety values ( 'CC01', 'Romantyczne wzgorza', 80, 'Bukiet z roz', 4 );
insert into bukiety values ( 'CC02', 'Mieszanka kwiatowa', 75, 'Bukiet z wielu rodzajow kwiatow', 10 );
insert into bukiety values ( 'CC03', 'Kwiatowe niebo', 71, 'Bukiet z tulipanow', 2 );
insert into bukiety values ( 'CC04', 'Wschodnia fantazja', 63, 'Bukiet z hiacyntow', 1 );
insert into bukiety values ( 'CC05', 'Francuska podroz', 90, 'Bukiet z francuskich roz', 6 );
insert into bukiety values ( 'CC06', 'Zapach wiosny', 81, 'Wiosenny bukiet z dalii i amarylisów', 3 );
insert into bukiety values ( 'CC07', 'Na kazda okazje', 79, 'Kolorowy bukiet na kazda okazje', 6 );

insert into kompozycje values ( 1, 'CC00', 4);
insert into kompozycje values ( 1, 'CC01', 2);

insert into kompozycje values ( 2, 'CC02', 4);
insert into kompozycje values ( 2, 'CC05', 4);
insert into kompozycje values ( 2, 'CC04', 4);

insert into kompozycje values ( 3, 'CC03', 4);

insert into kompozycje values ( 4, 'CC05', 4);
insert into kompozycje values ( 4, 'CC02', 4);

insert into kompozycje values ( 5, 'CC01', 4);
insert into kompozycje values ( 5, 'CC02', 4);
insert into kompozycje values ( 5, 'CC07', 4);

insert into kompozycje values ( 6, 'CC06', 4);
insert into kompozycje values ( 6, 'CC05', 4);
insert into kompozycje values ( 6, 'CC04', 4);

insert into kompozycje values ( 7, 'CC02', 4);

insert into kompozycje values ( 8, 'CC04', 4);

insert into kompozycje values ( 9, 'CC05', 4);
insert into kompozycje values ( 9, 'CC06', 4);
insert into kompozycje values ( 9, 'CC01', 4);
insert into kompozycje values ( 9, 'CC02', 4);
insert into kompozycje values ( 9, 'CC03', 4);

insert into kompozycje values ( 10, 'CC05', 4);
insert into kompozycje values ( 10, 'CC01', 4);

insert into kompozycje values ( 11, 'CC02', 4);

insert into kompozycje values ( 12, 'CC04', 4);
insert into kompozycje values ( 12, 'CC01', 4);
insert into kompozycje values ( 12, 'CC02', 4);

insert into kompozycje values ( 13, 'CC07', 4);
insert into kompozycje values ( 13, 'CC05', 4);

insert into kompozycje values ( 14, 'CC04', 4);

insert into kompozycje values ( 15, 'CC03', 4);

insert into kompozycje values ( 16, 'CC06', 4);

insert into kompozycje values ( 17, 'CC04', 4);

insert into kompozycje values ( 18, 'CC01', 4);

insert into kompozycje values ( 19, 'CC02', 4);
insert into kompozycje values ( 19, 'CC03', 4);
insert into kompozycje values ( 19, 'CC05', 4);
insert into kompozycje values ( 19, 'CC06', 4);

insert into kompozycje values ( 20, 'CC01', 4);

insert into kompozycje values ( 21, 'CC02', 4);
insert into kompozycje values ( 21, 'CC07', 4);

insert into kompozycje values ( 22, 'CC01', 4);
insert into kompozycje values ( 22, 'CC04', 4);

insert into kompozycje values ( 23, 'CC05', 4);




insert into skladowe values ( 'CC00' , 'AA00', 4);
insert into skladowe values ( 'CC00' , 'AA04', 2);
insert into skladowe values ( 'CC00' , 'AA08', 3);
insert into skladowe values ( 'CC00' , 'AA13', 1);

insert into skladowe values ( 'CC01' , 'AA00', 1);
insert into skladowe values ( 'CC01' , 'AA01', 2);
insert into skladowe values ( 'CC01' , 'AA02', 3);
insert into skladowe values ( 'CC01' , 'AA03', 2);
insert into skladowe values ( 'CC01' , 'AA04', 1);
insert into skladowe values ( 'CC01' , 'AA05', 1);

insert into skladowe values ( 'CC02' , 'AA01', 4);
insert into skladowe values ( 'CC02' , 'AA02', 4);
insert into skladowe values ( 'CC02' , 'AA03', 4);
insert into skladowe values ( 'CC02' , 'AA04', 4);
insert into skladowe values ( 'CC02' , 'AA05', 4);
insert into skladowe values ( 'CC02' , 'AA06', 4);
insert into skladowe values ( 'CC02' , 'AA08', 4);
insert into skladowe values ( 'CC02' , 'AA10', 4);
insert into skladowe values ( 'CC02' , 'AA11', 4);
insert into skladowe values ( 'CC02' , 'AA12', 4);

insert into skladowe values ( 'CC03' , 'AA06', 4);
insert into skladowe values ( 'CC03' , 'AA07', 4);
insert into skladowe values ( 'CC03' , 'AA08', 4);

insert into skladowe values ( 'CC04' , 'AA10', 9);

insert into skladowe values ( 'CC05' , 'AA04', 7);

insert into skladowe values ( 'CC06' , 'AA09', 7);
insert into skladowe values ( 'CC06' , 'AA11', 6);

insert into skladowe values ( 'CC07' , 'AA01', 4);
insert into skladowe values ( 'CC07' , 'AA05', 7);
insert into skladowe values ( 'CC07' , 'AA12', 9);


insert into dodatki values ( 'CC00' , 'BB00', 1);
insert into dodatki values ( 'CC00' , 'BB05', 2);

insert into dodatki values ( 'CC01' , 'BB03', 1);

insert into dodatki values ( 'CC02' , 'BB01', 2);
insert into dodatki values ( 'CC02' , 'BB05', 1);
insert into dodatki values ( 'CC02' , 'BB03', 2);

insert into dodatki values ( 'CC03' , 'BB04', 1);

insert into dodatki values ( 'CC04' , 'BB01', 1);

insert into dodatki values ( 'CC05' , 'BB03', 2);

insert into dodatki values ( 'CC06' , 'BB04', 1);
insert into dodatki values ( 'CC06' , 'BB00', 3);

insert into dodatki values ( 'CC07' , 'BB05', 1);
insert into dodatki values ( 'CC07' , 'BB02', 2);
insert into dodatki values ( 'CC07' , 'BB03', 1);




