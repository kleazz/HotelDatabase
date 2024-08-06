create database Hoteli;
use Hoteli;

create table TeDhenat(
NrPersonal bigint primary key,
Emri varchar(20) not null,
Mbiemri VARCHAR(25) not null,
Email VARCHAR(50)UNIQUE not null,
DataLindjes DATE not null,
Qyteti VARCHAR(30)default null,
Rruga VARCHAR(40)default null,
ZipKodi int default null,
)

create table Stafi(
IdStafi int not null foreign key references Stafi(IdStafi),
primary key(IdStafi),
NrPersonal bigint not null foreign key references TeDhenat(NrPersonal)on delete cascade on update cascade,
)

create table Kartela(
	IdKartela int not null primary key
)

create table KartelaSpeciale(
	IdKartela int not null foreign key references Kartela(IdKartela) on delete cascade on update cascade,
	primary key (IdKartela)
)

create table Admini(
IdAdmini int not null foreign key references Stafi(IdStafi)on delete cascade on update cascade,
primary key(IdAdmini),
IdKartela int not null foreign key references KartelaSpeciale(IdKartela),
UserLevel varchar(50) not null,
Username varchar(50) unique,
Passwordi varchar(50) check (len(Passwordi)>=8),
Paga decimal (8,2) default 700,
)


create table Recepcionisti(
IdRecepcionisti int not null foreign key references Stafi(IdStafi)on delete cascade on update cascade,
Paga decimal (8,2) default 450.50,
primary key(IdRecepcionisti),
)



create table Sherbyesi(
IdSherbyesi int not null foreign key references Stafi(IdStafi)on delete cascade on update cascade,
primary key(IdSherbyesi),
Paga decimal (8,2) default 420,
)

create table HapesiraShtese(
	IdHapesira int not null primary key,
	Kati int not null
)

create table Mirembajtesi(
IdMirembajtesi int not null foreign key references Stafi(IdStafi)on delete cascade on update cascade,
primary key(IdMirembajtesi),
IdKartela int not null foreign key references KartelaSpeciale(IdKartela),--on del
IdHapesira int not null foreign key references HapesiraShtese(IdHapesira),--on del
Paga decimal (8,2) default 370.25,
)



create table Mysafiri(
IdMysafiri int primary key,
NrPersonal bigint not null foreign key references TeDhenat(NrPersonal)on delete cascade on update cascade,
IdHapesira int not null foreign key references HapesiraShtese(IdHapesira)on delete cascade on update cascade
)



create table Pagesa(
IdPageses int primary key,
Menyra char(4) not null,
Shuma decimal(8, 2) not null,
DataPageses date not  null,
IdRecepcionisti int not null foreign key references Recepcionisti(IdRecepcionisti),
)





create table NrTel(
NrTel int not null,
NrPersonal bigint not null foreign key references TeDhenat(NrPersonal)on delete cascade on update cascade,
primary key(NrTel,NrPersonal),
)


create table Porosia(
LLojiPorosise varchar(20) primary key,
)



create table SherbimiPorosise(
IdSherbyesi int not null foreign key references Sherbyesi(IdSherbyesi)on delete cascade on update cascade,
LlojiPorosise varchar(20)not null foreign key references Porosia(LlojiPorosise)on delete cascade on update cascade,
primary key(IdSherbyesi,LlojiPorosise),
)


---------------------------------------------------------------------------

create table Rezervimi(
	IdRezervimi int not null primary key,
	IdRecepcionisti int not null foreign key references Recepcionisti(IdRecepcionisti),
	IdPageses int not null foreign key references Pagesa(IdPageses),
	IdMysafiri int not null foreign key references Mysafiri(IdMysafiri),
	KohaQendrimit varchar(7) not null,
	CheckIn date not null,
	CheckOut date not null
)

create table RezOnline(
	IdRezervimi int not null foreign key references Rezervimi(IdRezervimi) on delete cascade on update cascade,
	primary key(IdRezervimi)
)

create table RezFizik(
	IdRezervimi int not null foreign key references Rezervimi(IdRezervimi) on delete cascade on update cascade,
	primary key (IdRezervimi)
)



create table LlojiDhomes(
	IdLloji int not null primary key,
	nrShtreterve int not null,
	WiFi char(2) not null check(WiFi in('Po','Jo')),
	Klima char(2) not null check(Klima in('Po','Jo')),
	Pamja varchar(25) not null,
	Ballkoni char(2) not null check(Ballkoni in('Po','Jo')),
	Sauna char(2) not null check(Sauna in('Po','Jo')),
	TV char(2) not null check(TV in('Po','Jo')), 
	MaxNjerez int not null
)

create table Dhoma(
	NrDhomes int not null primary key,
	IdLloji int not null foreign key references LlojiDhomes(IdLloji)on delete cascade on update cascade,
	IdRezervimi int not null foreign key references Rezervimi(IdRezervimi)on delete cascade on update cascade,
	IdKartela int not null foreign key references KartelaSpeciale(IdKartela)on delete cascade on update cascade
)

create table KartelaRregullt(
	IdKartelaRregullt int not null foreign key references Kartela(IdKartela),
	primary key (IdKartelaRregullt),
	IdMysafiri int not null foreign key references Mysafiri(IdMysafiri),
	NrDhomes int not null foreign key references Dhoma(NrDhomes) on delete cascade on update cascade
)



create table SPA(
	IdHapesira int not null FOREIGN KEY references HapesiraShtese (IdHapesira) on delete cascade on update cascade,
	PRIMARY KEY (IdHapesira),
	Gym char(2) not null check(gym in('Po','Jo')),
	Jakuzi char(2) not null check(jakuzi in('Po','Jo')),
	NrPishinave int not null,
	NrShtreterve int not null
)

create table SallaNgrenjes(
	IdHapesira int foreign key references HapesiraShtese(idHapesira)on delete cascade on update cascade,
	primary key (IdHapesira),
	NrTavolinave int not null,
	NrKarrigeve int not null
)

create table SherbimiDhomes(
	LlojiPorosise varchar(20) not null foreign key references Porosia on delete cascade on update cascade,
	IdMysafiri int not null foreign key (IdMysafiri) references Mysafiri on delete cascade on update cascade,
	IdPageses int not null foreign key references Pagesa(IdPageses)on delete cascade on update cascade,
	primary key (llojiPorosise,IdMysafiri)
)

create table Dergesa(
	LlojiPorosise varchar(20) not null,
	IdMysafiri int not null,
	NrDhomes int not null foreign key (NrDhomes) references Dhoma on delete cascade on update cascade,
	primary key (LlojiPorosise,NrDhomes,IdMysafiri),
	foreign key (LlojiPorosise,IdMysafiri) references SherbimiDhomes on delete cascade on update cascade,
)


create table MirembajtjaDhomess(
	NrDhomes int not null foreign key (NrDhomes) references Dhoma on delete cascade on update cascade,
	IdMirembajtesi int not null foreign key (IdMirembajtesi) references Mirembajtesi on delete cascade on update cascade,
	primary key (NrDhomes, idMirembajtesi)
)


insert into TeDhenat values(2837483933,'Hana','Kastrati','hanakastrati@gmail.com','1998-02-09','Peje','Hasan Prishtina',30000);
insert into TeDhenat values(1176338292,'Anjesa','Abazi','anjesaabazi@gmail.com','2003-01-09','Prishtine','Iliaz Kodra',10000);
insert into TeDhenat values(2732828348,'Alisa','Abazi','alisaabazi@gmail.com','2000-01-20','Prishtine','Iliaz Kodra',10000);
insert into TeDhenat values(8474583048,'Arti','Berisha','artiberisha@gmail.com','2003-10-13','Mitrovice','Mehmet Gradica',40000);
insert into TeDhenat values(3232233135,'Suzana','Mamaj','suzanamamaj@gmail.com','2000-03-13','Peje','Wesley K.Clark',30000);
insert into TeDhenat values(2832997273,'Agnesa','Hoti','agnesahoti@gmail.com','2002-04-02','Gjakove','Brigada Letrare',50000);
insert into TeDhenat values(6673382937,'Luan','Gashi','luangashi@gmail.com','2001-01-15','Prishtine','Fehmi Agani',10000);
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4536768902,'Rita','Mala','ritamala@outlook.com','2003-07-09');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(6788902314,'Klea','Kasapolli','kleakasapolli@gmail.com','2003-12-24');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(1234543267,'Blerta','Salihu','blertasalihu@yahoo.com','2003-04-01');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(8976435266,'Rona','Bala','ronabala@outlook.com','1990-07-08');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3224566421,'Monika','Shala','monikashala@gmail.com','1997-06-29');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3746382972,'Vatan','Haxhia','vatanhaxhia@yahoo.com','1988-09-12');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3827354830,'Vesa','Hoxha','vesahoxha@outlook.com','2003-02-13');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3263637388,'Arben','Matoshi','arbenmatoshi@gmail.com','1991-04-13');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4221263537,'Vlera','Muhaxheri','vleramuhaxheri@yahoo.com','2003-02-22');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3746382973,'Rina','Haxhisefa','rinahaxhisefa@yahoo.com','2003-01-20');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3827354832,'Roni','Kelmendi','ronikelmendi@outlook.com','2000-05-14');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3263637399,'Vanesa','Zekaj','vanesazekaj@gmail.com','2003-07-22');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4221263547,'Yllka','Zeka','yllkazeka@yahoo.com','2003-09-08');
insert into TeDhenat values(4824528648,'Agon','Bytyqi','agonbytyqi@gmail.com','1998-02-04','Peje','Mbreti Pirro',30000);
insert into TeDhenat values(3635273628,'Driton','Mala','dritonmala@gmail.com','2003-05-03','Prishtine','28 Nentori',10000);
insert into TeDhenat values(3837372923,'Erdi','Sadiku','erdisadiku2000@gmail.com','2000-03-27','Prishtine','Rrustem Statovci',10000);
insert into TeDhenat values(3474537283,'Blerina','Gjuka','blerinagjuka@gmail.com','2003-10-13','Mitrovice','Dëshmorët e Kombit',40000);
insert into TeDhenat values(3482829372,'Leon','Belegu','leonbelegu@gmail.com','2000-02-12','Peje','Esad Mekuli',30000);
insert into TeDhenat values(4859738463,'Anjeza','Nuza','anjezanuza@gmail.com','2002-08-07','Gjakove','Hysni Dubrava',50000);
insert into TeDhenat values(4838478263,'Luan','Gashi','luangashi1@gmail.com','2001-01-15','Prishtine','Sadik Stavileci',10000);
insert into TeDhenat values(4859738464,'Erjon','Peja','erjonpeja02@gmail.com','2002-11-12','Gjakove','Marin Barleti',50000);
insert into TeDhenat values(4838478265,'Arjeta','Thaçi','thaciarjeta@gmail.com','2001-12-19','Prishtine','Lidhja e Prizrenit',10000);
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4837368957,'Rea','Dina','r3adin4@outlook.com','2003-03-03');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(8478567536,'Elon','Muharremi','muharremieloni@gmail.com','2003-12-03');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3348747454,'Blendi','Avdiu','blendiiavdiu@yahoo.com','2003-04-01');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(8344638744,'Rona','Malaj','ronamalaj@yahoo.com','1990-08-07');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4738479374,'Vera','Kajabegolli','vera.kajabegolli@gmail.com','2001-12-27');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3348384648,'Ermal','Ademi','ermaliademi@outlook.com','1996-03-09');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(8273874893,'Ari','Shalaj','shalajari1@gmail.com','1997-10-03');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(4478373846,'Jona','Salihu','eraasalihu@gmail.com','2002-04-15');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3849388893,'Genc','Kasapolli','g_kasapolli@yahoo.com','1984-02-21');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(2749576849,'Albi','Jakupi','jakupialbi@yahoo.com','2003-01-21');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(7354273645,'Endrit','Berisha','endrit_berisha@outlook.com','2000-05-25');
insert into TeDhenat values(3826583821,'Aurora','Haxha','aurorahaxxha@gmail.com','2002-10-08','Gjakove','Haxhi Zeka',50000);
insert into TeDhenat values(5637283829,'Nita','Gashi','nita_gashi@gmail.com','2001-05-03','Prishtine','Karl Gega',10000);
insert into TeDhenat values(3284747112,'Dielli','Krasniqi','diellkrasniqi@gmail.com','2002-08-04','Ferizaj','Washington',70000);
insert into TeDhenat values(5546782234,'Anduena','Bajraktari','anduena.bajraktari@gmail.com','2001-06-21','Prishtine','Meto Bajraktari',10000);
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3723211257,'Petrit','Basha','bashapetrit@outlook.com','2000-10-22');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(9475632374,'Elza','Dobruna','elzadobruna@gmail.com','2002-02-14');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(3283747282,'Ron','Shabani','ronshabani@yahoo.com','2003-05-01');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(1235467488,'Elona','Kryeziu','elonaakryeziu@yahoo.com','2001-07-11');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(5747382232,'Aulona','Sopi','aulonasopi@gmail.com','2001-11-16');
insert into TeDhenat(NrPersonal,Emri,Mbiemri,Email,DataLindjes)values(2234785641,'Rinor','Demaj','rinordemaj@outlook.com','1997-04-13');


insert into NrTel values(049-999-999,1176338292);
insert into NrTel values(044-937-529,2732828348);
insert into NrTel values(045-328-475,1176338292);
insert into NrTel values(049-829-362,1176338292);
insert into NrTel values(049-288-576,2732828348);
insert into NrTel values(044-488-527,6673382937);
insert into NrTel values(049-346-564,2832997273);
insert into NrTel values(045-628-931,4536768902);
insert into NrTel values(045-529-152,6788902314);
insert into NrTel values(049-358-713,4536768902);
 

insert into Stafi values (1,2837483933);
insert into Stafi values (2,1176338292);
insert into Stafi values (3,2732828348);
insert into Stafi values (4,8474583048);
insert into Stafi values (5,3232233135);
insert into Stafi values (6,2832997273);
insert into Stafi values (7,6673382937);
insert into Stafi values (8,4536768902);
insert into Stafi values (9,6788902314);
insert into Stafi values (10,1234543267);
insert into Stafi values (11,8976435266);
insert into Stafi values (12,3224566421);
insert into Stafi values (13,3746382972);
insert into Stafi values (14,3827354830);
insert into Stafi values (15,3263637388);
insert into Stafi values (16,4221263537);
insert into Stafi values (17,3746382972);
insert into Stafi values (18,3827354830);
insert into Stafi values (19,3263637388);
insert into Stafi values (20,4221263537);
insert into Stafi values (21,4824528648);
insert into Stafi values (22,3635273628);
insert into Stafi values (23,3837372923);
insert into Stafi values (24,3474537283);
insert into Stafi values (25,3482829372);
insert into Stafi values (26,4859738463);
insert into Stafi values (27,4838478263);
insert into Stafi values (28,4859738463);
insert into Stafi values (29,4838478263);
insert into Stafi values (30,4837368957);
insert into Stafi values (31,8478567536);
insert into Stafi values (32,3348747454);
insert into Stafi values (33,8344638744);
insert into Stafi values (34,4738479374);
insert into Stafi values (35,3348384648);
insert into Stafi values (36,8273874893);
insert into Stafi values (37,4478373846);
insert into Stafi values (38,3849388893);
insert into Stafi values (39,2749576849);
insert into Stafi values (40,7354273645);

insert into Kartela values(110);
insert into Kartela values(111);
insert into Kartela values(112);
insert into Kartela values(113);
insert into Kartela values(114);
insert into Kartela values(115);
insert into Kartela values(116);
insert into Kartela values(117);
insert into Kartela values(118);
insert into Kartela values(119);
insert into Kartela values(220);
insert into Kartela values(221);
insert into Kartela values(222);
insert into Kartela values(223);
insert into Kartela values(224);
insert into Kartela values(225);
insert into Kartela values(226);
insert into Kartela values(227);
insert into Kartela values(228);
insert into Kartela values(229);
insert into Kartela values(230);
insert into Kartela values(231);
insert into Kartela values(232);
insert into Kartela values(233);
insert into Kartela values(234);
insert into Kartela values(235);
insert into Kartela values(236);
insert into Kartela values(237);
insert into Kartela values(238);
insert into Kartela values(239);



insert into KartelaSpeciale values(220);
insert into KartelaSpeciale values(221);
insert into KartelaSpeciale values(222);
insert into KartelaSpeciale values(223);
insert into KartelaSpeciale values(224);
insert into KartelaSpeciale values(225);
insert into KartelaSpeciale values(226);
insert into KartelaSpeciale values(227);
insert into KartelaSpeciale values(228);
insert into KartelaSpeciale values(229);
insert into KartelaSpeciale values(230);
insert into KartelaSpeciale values(231);
insert into KartelaSpeciale values(232);
insert into KartelaSpeciale values(233);
insert into KartelaSpeciale values(234);
insert into KartelaSpeciale values(235);
insert into KartelaSpeciale values(236);
insert into KartelaSpeciale values(237);
insert into KartelaSpeciale values(238);
insert into KartelaSpeciale values(239);

insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (1,220,'Billing admin','b.admin1','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (3,221,'Help desk Admin','h.admin1','12345678');
insert into Admini values (2,222,'Global admin','g.admin1','12345678',1000);
insert into Admini values (4,223,'Global admin','g.admin2','12345678',1000);
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (5,224,'Room Admin','r.admin1','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (6,225,'Help desk Admin','h.admin2','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (7,226,'Billing admin','b.admin2','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (8,227,'Room Admin','r.admin2','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (9,228,'Room Admin','r.admin3','12345678');
insert into Admini(IdAdmini,IdKartela,UserLevel,Username,Passwordi)values (10,229,'Guest Experience Admin','ge.admin1','12345678');


insert into HapesiraShtese values (11,1);
insert into HapesiraShtese values (22,1);
insert into HapesiraShtese values (33,1);
insert into HapesiraShtese values (44,2);
insert into HapesiraShtese values (55,2);
insert into HapesiraShtese values (66,2);
insert into HapesiraShtese values (77,3);
insert into HapesiraShtese values (88,3);
insert into HapesiraShtese values (99,3);
insert into HapesiraShtese values (111,1);
insert into HapesiraShtese values (222,1);
insert into HapesiraShtese values (333,1);
insert into HapesiraShtese values (444,2);
insert into HapesiraShtese values (555,2);
insert into HapesiraShtese values (666,2);
insert into HapesiraShtese values (777,3);
insert into HapesiraShtese values (888,3);
insert into HapesiraShtese values (999,3);
insert into HapesiraShtese values (1,1);
insert into HapesiraShtese values (2,1);


insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(31,230,11);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(32,231,11);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(33,232,22);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(34,233,22);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(35,234,44);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(36,235,55);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(37,236,66);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(38,237,55);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(39,238,77);
insert into Mirembajtesi(IdMirembajtesi,IdKartela,IdHapesira) values(40,239,88);


 
insert into Recepcionisti(IdRecepcionisti) values(11);
insert into Recepcionisti(IdRecepcionisti) values(12);
insert into Recepcionisti(IdRecepcionisti) values(13);
insert into Recepcionisti(IdRecepcionisti) values(14);
insert into Recepcionisti(IdRecepcionisti) values(15);
insert into Recepcionisti(IdRecepcionisti) values(16);
insert into Recepcionisti(IdRecepcionisti) values(17);
insert into Recepcionisti(IdRecepcionisti) values(21);
insert into Recepcionisti(IdRecepcionisti) values(22);
insert into Recepcionisti(IdRecepcionisti) values(23);


insert into Sherbyesi(IdSherbyesi) values(18);
insert into Sherbyesi(IdSherbyesi) values(19);
insert into Sherbyesi(IdSherbyesi) values(20);
insert into Sherbyesi(IdSherbyesi) values(24);
insert into Sherbyesi(IdSherbyesi) values(25);
insert into Sherbyesi(IdSherbyesi) values(26);
insert into Sherbyesi(IdSherbyesi) values(27);
insert into Sherbyesi(IdSherbyesi) values(28);
insert into Sherbyesi(IdSherbyesi) values(29);
insert into Sherbyesi(IdSherbyesi) values(30);
 

insert into Mysafiri values (1,3826583821,11);
insert into Mysafiri values (3,5637283829,22);
insert into Mysafiri values (2,3284747112,33);
insert into Mysafiri values (5,5546782234,55);
insert into Mysafiri values (4,3723211257,66);
insert into Mysafiri values (6,9475632374,77);
insert into Mysafiri values (7,3283747282,99);
insert into Mysafiri values (8,1235467488,111);
insert into Mysafiri values (9,5747382232,888);
insert into Mysafiri values (10,2234785641,2);


insert into Pagesa values(1,'Cash',10200,'2022-12-24',11);
insert into Pagesa values(2,'Card',9000.5,'2022-07-09',12);
insert into Pagesa values(3,'Card',255,'2020-03-20',13);
insert into Pagesa values(4,'Card',740,'2021-08-18',14);
insert into Pagesa values(5,'Cash',300,'2022-10-25',15);
insert into Pagesa values(6,'Cash',1230,'2022-10-31',16);
insert into Pagesa values(7,'Cash',5000,'2022-11-30',17);
insert into Pagesa values(8,'Card',8000.5,'2022-12-31',21);
insert into Pagesa values(9,'Cash',235.35,'2021-12-24',21);
insert into Pagesa values(10,'Card',400,'2019-06-01',22);
insert into Pagesa values(11,'Cash',1000,'2020-11-22',23);
insert into Pagesa values(12,'Card',8000.5,'2019-06-10',11);
insert into Pagesa values(13,'Card',275,'2021-02-25',12);
insert into Pagesa values(14,'Card',540,'2020-07-17',13);
insert into Pagesa values(15,'Cash',600,'2020-02-21',14);
insert into Pagesa values(16,'Cash',1130,'2021-11-18',15);
insert into Pagesa values(17,'Cash',6000,'2021-10-30',16);
insert into Pagesa values(18,'Card',7000.5,'2020-12-31',17);
insert into Pagesa values(19,'Card',935.35,'2020-12-24',21);
insert into Pagesa values(20,'Card',600,'2018-07-09',23);
insert into Pagesa values(21,'Cash',10,'2020-12-22',11);
insert into Pagesa values(22,'Card',80.5,'2019-07-10',12);
insert into Pagesa values(23,'Card',27,'2021-03-25',22);
insert into Pagesa values(24,'Card',54,'2020-08-17',23);
insert into Pagesa values(25,'Cash',6,'2020-03-21',17);
insert into Pagesa values(26,'Cash',11,'2021-12-18',16);
insert into Pagesa values(27,'Cash',60,'2021-11-30',15);
insert into Pagesa values(28,'Card',7.5,'2020-11-30',11);
insert into Pagesa values(29,'Card',9.35,'2020-12-24',12);
insert into Pagesa values(30,'Card',600,'2018-06-09',13);
insert into Pagesa values(31,'Cash',200,'2020-07-09',11);

insert into Porosia values('Higjiene');
insert into Porosia values('Mengjes');
insert into Porosia values('Dreke');
insert into Porosia values('Darke');
insert into Porosia values('Desert');
insert into Porosia values('Pije alkoolike');
insert into Porosia values('Pije joalkoolike');
insert into Porosia values('Asistim');
insert into Porosia values('Shujte e lehte');
insert into Porosia values('Dekor');

insert into SherbimiPorosise values(18,'Dekor')
insert into SherbimiPorosise values(18,'Pije alkoolike')
insert into SherbimiPorosise values(19,'Shujte e lehte')
insert into SherbimiPorosise values(20,'Shujte e lehte')
insert into SherbimiPorosise values(30,'Asistim')
insert into SherbimiPorosise values(24,'Higjiene')
insert into SherbimiPorosise values(25,'Higjiene')
insert into SherbimiPorosise values(26,'Mengjes')
insert into SherbimiPorosise values(26,'Dreke')
insert into SherbimiPorosise values(19,'Asistim')
insert into SherbimiPorosise values(29,'Darke')
insert into SherbimiPorosise values(24,'Dreke')
insert into SherbimiPorosise values(28,'Higjiene')
insert into SherbimiPorosise values(18,'Desert')
insert into SherbimiPorosise values(19,'Pije alkoolike')
insert into SherbimiPorosise values(25,'Pije joalkoolike')
insert into SherbimiPorosise values(30,'Pije joalkoolike')
insert into SherbimiPorosise values(20,'Desert')
insert into SherbimiPorosise values(20,'Pije joalkoolike')
insert into SherbimiPorosise values(25,'Desert')
insert into SherbimiPorosise values(26,'Higjiene')
insert into SherbimiPorosise values(27,'Mengjes')
insert into SherbimiPorosise values(27,'Desert')
insert into SherbimiPorosise values(29,'Pije alkoolike')
insert into SherbimiPorosise values(28,'Pije alkoolike')
insert into SherbimiPorosise values(30,'Mengjes')

insert into Rezervimi values(10200,11,1,1,'2 netë','2023-01-01','2023-01-03');
insert into Rezervimi values(10201,12,2,2,'4 netë','2023-01-03','2023-01-07');
insert into Rezervimi values(10202,13,3,3,'4 netë','2023-01-04','2023-01-08');
insert into Rezervimi values(10203,14,4,4,'1 natë','2023-01-05','2023-01-06');
insert into Rezervimi values(10204,15,5,5,'1 natë','2023-01-10','2023-01-11');
insert into Rezervimi values(10205,16,6,6,'1 natë','2023-01-10','2023-01-11');
insert into Rezervimi values(10206,17,7,7,'2 netë','2023-01-02','2023-01-04');
insert into Rezervimi values(10207,21,8,8,'6 netë','2023-01-04','2023-01-10');
insert into Rezervimi values(10208,22,9,9,'2 netë','2023-01-05','2023-01-07');
insert into Rezervimi values(10209,23,10,10,'2 netë','2023-01-05','2023-01-07');
insert into Rezervimi values(10210,11,11,10,'3 netë','2023-01-10','2023-01-13');
insert into Rezervimi values(10211,12,12,9,'2 netë','2023-01-16','2023-01-18');
insert into Rezervimi values(10212,13,13,8,'1 natë','2023-01-17','2023-01-18');
insert into Rezervimi values(10213,14,14,7,'1 natë','2023-01-20','2023-01-21');
insert into Rezervimi values(10214,15,17,6,'1 natë','2023-01-20','2023-01-21');
insert into Rezervimi values(10215,16,15,5,'2 netë','2023-01-21','2023-01-23');
insert into Rezervimi values(10216,17,16,4,'4 netë','2023-01-12','2023-01-16');
insert into Rezervimi values(10217,21,18,3,'4 netë','2023-01-12','2023-01-16');
insert into Rezervimi values(10218,22,19,2,'2 netë','2023-01-17','2023-01-19');
insert into Rezervimi values(10219,23,20,1,'3 netë','2023-01-20','2023-01-23');


insert into RezOnline values(10200);
insert into RezOnline values(10201);
insert into RezOnline values(10202);
insert into RezOnline values(10203);
insert into RezOnline values(10204);
insert into RezOnline values(10205);
insert into RezOnline values(10216);
insert into RezOnline values(10217);
insert into RezOnline values(10218);
insert into RezOnline values(10219);


insert into RezFizik values(10206);
insert into RezFizik values(10207);
insert into RezFizik values(10208);
insert into RezFizik values(10209);
insert into RezFizik values(10210);
insert into RezFizik values(10211);
insert into RezFizik values(10212);
insert into RezFizik values(10213);
insert into RezFizik values(10214);
insert into RezFizik values(10215);




insert into LlojiDhomes values (1,2,'Po','Po','Lumbardhi','Po','Po','Po',4);
insert into LlojiDhomes values (2,2,'Po','Po','Rugova','Po','Po','Po',4);
insert into LlojiDhomes values (3,2,'Po','Po','Korza','Po','Jo','Po',4);
insert into LlojiDhomes values (4,3,'Po','Po','Lumbardhi','Po','Po','Po',7);
insert into LlojiDhomes values (5,3,'Po','Po','Rugova','Po','Jo','Po',7);
insert into LlojiDhomes values (6,3,'Po','Po','Korza','Po','Jo','Po',7);
insert into LlojiDhomes values (7,4,'Po','Po','Lumbardi','Po','Po','Po',10);
insert into LlojiDhomes values (8,4,'Po','Po','Rugova','Po','Po','Po',10);
insert into LlojiDhomes values (9,1,'Po','Po','Lumbardhi','Po','Po','Po',2);
insert into LlojiDhomes values (10,1,'Po','Po','Rugova','Po','Jo','Po',2);




insert into Dhoma values(200,1,10200,220);
insert into Dhoma values(202,2,10204,221);
insert into Dhoma values(204,3,10205,222);
insert into Dhoma values(206,4,10208,223);
insert into Dhoma values(208,5,10209,224);
insert into Dhoma values(300,6,10210,225);
insert into Dhoma values(302,7,10211,226);
insert into Dhoma values(304,8,10216,227);
insert into Dhoma values(306,9,10217,228);
insert into Dhoma values(308,10,10219,229);



insert into KartelaRregullt values(110,1,200);
insert into KartelaRregullt values(111,2,202);
insert into KartelaRregullt values(112,3,204);
insert into KartelaRregullt values(113,4,208);
insert into KartelaRregullt values(114,5,300);
insert into KartelaRregullt values(115,6,302);
insert into KartelaRregullt values(116,7,304);
insert into KartelaRregullt values(117,8,306);
insert into KartelaRregullt values(118,9,308);
insert into KartelaRregullt values(119,10,206);

insert into SPA values(11,'Po','Po',4,20);
insert into SPA values(22,'Po','Jo',3,15);
insert into SPA values(33,'Jo','Po',2,10);
insert into SPA values(44,'Po','Po',4,20);
insert into SPA values(55,'Po','Jo',3,15);
insert into SPA values(66,'Jo','Po',2,10);
insert into SPA values(77,'Po','Po',4,20);
insert into SPA values(88,'Po','Jo',3,15);
insert into SPA values(99,'Jo','Po',2,10);
insert into SPA values(1,'Po','Po',4,20);


insert into SallaNgrenjes values(111,5,25);
insert into SallaNgrenjes values(222,10,50);
insert into SallaNgrenjes values(333,20,100);
insert into SallaNgrenjes values(444,5,25);
insert into SallaNgrenjes values(555,10,50);
insert into SallaNgrenjes values(666,20,100);
insert into SallaNgrenjes values(777,5,25);
insert into SallaNgrenjes values(888,10,50);
insert into SallaNgrenjes values(999,20,100);
insert into SallaNgrenjes values(2,5,25);


insert into SherbimiDhomes values('Higjiene',1,21);
insert into SherbimiDhomes values('Higjiene',2,22);
insert into SherbimiDhomes values('Mengjes',2,23);
insert into SherbimiDhomes values('Dreke',6,24);
insert into SherbimiDhomes values('Higjiene',3,23);
insert into SherbimiDhomes values('Desert',5,26);
insert into SherbimiDhomes values('Pije alkoolike',4,24);
insert into SherbimiDhomes values('Shujte e lehte',7,27);
insert into SherbimiDhomes values('Higjiene',8,27);
insert into SherbimiDhomes values('Pije joalkoolike',3,23);
insert into SherbimiDhomes values('Higjiene',6,22);
insert into SherbimiDhomes values('Dekor',8,21);
insert into SherbimiDhomes values('Desert',6,30);
insert into SherbimiDhomes values('Higjiene',10,31);
insert into SherbimiDhomes values('Darke',8,25);
insert into SherbimiDhomes values('Pije alkoolike',1,21);
insert into SherbimiDhomes values('Mengjes',9,31);
insert into SherbimiDhomes values('Darke',3,23);
insert into SherbimiDhomes values('Desert',1,21);
insert into SherbimiDhomes values('Mengjes',4,24);
insert into SherbimiDhomes values('Pije joalkoolike',1,22);
insert into SherbimiDhomes values('Asistim',6,27);
insert into SherbimiDhomes values('Pije alkoolike',8,25);
insert into SherbimiDhomes values('Dekor',2,22);
insert into SherbimiDhomes values('Dreke',3,23);


insert into Dergesa values('Higjiene',1,200);
insert into Dergesa values('Higjiene',1,208);
insert into Dergesa values('Mengjes',2,300);
insert into Dergesa values('Dreke',6,300);
insert into Dergesa values('Higjiene',3,202);
insert into Dergesa values('Desert',5,202);
insert into Dergesa values('Desert',5,204);
insert into Dergesa values('Pije alkoolike',4,206);
insert into Dergesa values('Shujte e lehte',7,206);
insert into Dergesa values('Higjiene',8,206);
insert into Dergesa values('Pije joalkoolike',3,208);
insert into Dergesa values('Higjiene',6,208);
insert into Dergesa values('Dekor',8,302);
insert into Dergesa values('Desert',5,302);
insert into Dergesa values('Higjiene',10,302);
insert into Dergesa values('Darke',8,308);
insert into Dergesa values('Pije alkoolike',1,308);
insert into Dergesa values('Mengjes',9,308);
insert into Dergesa values('Darke',3,304);
insert into Dergesa values('Desert',1,304);
insert into Dergesa values('Mengjes',4,304);
insert into Dergesa values('Pije joalkoolike',1,208);
insert into Dergesa values('Asistim',6,200);
insert into Dergesa values('Pije alkoolike',8,200);
insert into Dergesa values('Dekor',2,206);
insert into Dergesa values('Higjiene',2,300);
insert into Dergesa values('Dreke',3,302);


insert into MirembajtjaDhomess values(200,31);
insert into MirembajtjaDhomess values(202,32);
insert into MirembajtjaDhomess values(204,33);
insert into MirembajtjaDhomess values(206,34);
insert into MirembajtjaDhomess values(208,35);
insert into MirembajtjaDhomess values(300,36);
insert into MirembajtjaDhomess values(302,37);
insert into MirembajtjaDhomess values(304,38);
insert into MirembajtjaDhomess values(306,39);
insert into MirembajtjaDhomess values(308,40);
insert into MirembajtjaDhomess values(300,31);
insert into MirembajtjaDhomess values(302,32);
insert into MirembajtjaDhomess values(304,33);
insert into MirembajtjaDhomess values(306,34);
insert into MirembajtjaDhomess values(308,35);
insert into MirembajtjaDhomess values(200,36);
insert into MirembajtjaDhomess values(202,37);
insert into MirembajtjaDhomess values(204,37);
insert into MirembajtjaDhomess values(206,38);
insert into MirembajtjaDhomess values(208,31);
insert into MirembajtjaDhomess values(200,33);
insert into MirembajtjaDhomess values(204,38);
insert into MirembajtjaDhomess values(300,35);
insert into MirembajtjaDhomess values(304,40);
insert into MirembajtjaDhomess values(308,39);

--PJESA E DYTË

--1)Perditesimi i pages se adminit te caktuar me 10%
update [dbo].[Admini]
set Paga=Paga*1.1
where IdAdmini=10

--2)Perditesimi i rruges
update [dbo].[TeDhenat]
set Rruga='Skenderbeu'
where NrPersonal='1176338292' or NrPersonal='2732828348'

--3)Perditesimi per nivein e perdoruesit te adminit
update [dbo].[Admini]
set UserLevel='Help desk Admin'
where IdAdmini=8

--4)Perditesimi i hapesires te cilen mirembane mirembajtesji
update [dbo].Mirembajtesi
set IdHapesira=77
where IdHapesira=44

--5)Zbritja per 10% ne shumen e pagesave te kryera per Krishtlindje
update [dbo].[Pagesa]
set Shuma=Shuma*0.9
where DataPageses='2022-12-24'

--6)Perditesimi i emailit ne te dhenat personale
update [dbo].[TeDhenat]
set Email='syzanamamj@gmail.com'
where NrPersonal='3232233135'

--7)Perditesimi i rruges ne te dhenat personale
update [dbo].[TeDhenat]
set Rruga='Fan Noli'
where Rruga='Lidhja e Prizrenit' and Qyteti='Prishtine'

--8)Perditesimi i username per adminin e caktuar
update [dbo].[Admini]
set Username='h.admin3'
where IdAdmini=8

--9)Perditesimi i mysafirit qe posedon kartelen e rregullt
update [dbo].[KartelaRregullt]
set IdMysafiri=2
where IdMysafiri=1

--10)Perditesimi i llojit te porosise
update [dbo].[Porosia]
set LLojiPorosise='Pije alkoolike +18'
where LLojiPorosise='Pije alkoolike'


--11)Përditesimi i gjendjes së saunës në Dhomë
update LlojiDhomes
	set Sauna = 'Po'
	where Sauna = 'Jo'

--12)Përditsimi i datës së largimit në Rezervim
update Rezervimi
	set CheckOut = '2023-01-09'
	where CheckOut = '2023-01-07'

--13)Përditesim i pamjes në dhomë me Id=1
update LlojiDhomes
	set Pamja = 'Qarshia'
	where IdLloji = 1

--14)Përditsimi i gjendjes së TV-së me id=1
update LlojiDhomes
	set Tv = 'Jo'
	where IdLloji = 1

--15)Përditsimi i numrit te pishinave ne hapësiren me id=99
update SPA
	set NrPishinave = 5
	where IdHapesira = 99

--16)Përditsimi i numrit te tavolinave ne hapësiren me id=2
update SallaNgrenjes
	set NrTavolinave = 10   
	where IdHapesira = 2

--17)Përditsimi i dërgeses së porosisë nga dhoma 200 në dhomën 308
update Dergesa
	set NrDhomes = 200
	where NrDhomes = 308


--18)Përditsimi i recepcionistit që ka bërë rezervimin
update Rezervimi
	set IdRecepcionisti = 11
	where IdRecepcionisti = 12

--19)Përditsimi për numrin maksimal të njerëzve në dhome në bazë të shtretërve dhe me id=7
update LlojiDhomes
	set MaxNjerez = 8
	where nrShtreterve = 4 and IdLloji = 7 

--20)Përditsimi i gjendjes së gym-it në hapsirën shtesë
update SPA
	set Gym = 'Po'
	where Gym = 'Jo'

--1)Fshirja e Stafit me Id 1 dhe 3
delete from Stafi
where IdStafi=1 or IdStafi=3

--2)Fshirja e te dhenave te personave me emrin Hana dhe Arti
delete from TeDhenat
where Emri='Hana' or Emri='Arti'

--3)Fshirja e Pagesave te kryera nga recepcionisti me Id 15
delete from Pagesa
where IdRecepcionisti=15

--4)Fshirja e mirembajtesit qe posedon kartelen e caktuar
delete from Mirembajtesi
where IdKartela='233' 

--5)Fshirja e adminit sipas emrit dhe nivelit te perdoruesit
delete from Admini
where username='g.admin1' and UserLevel='Global admin'

--6)Fshirja e dhomes me numër 308
delete from Dhoma
	where NrDhomes =308

--7)Fshirja e rezervimeve të bëra me datën 01.05.2023
delete from Rezervimi
	where CheckIn = '2023-01-05'

--8)Fshirja e dhomave me pamje nga korza 
delete from LlojiDhomes
	where Pamja = 'Korza'

--9)Fshirja e rezervimit online me id=10203
delete from RezOnline
	where IdRezervimi = 10203

--10)Fshirja e rezervimit fizik me id=10213
delete from RezFizik
	where IdRezervimi = 10213



--RITA MALA PJESA TRETË

------------QUERY TE THJESHTA-------------
--1)Selektimi i te gjitha rezervimeve me kohe te qendrimit 2 netë
select *
from Rezervimi
where KohaQendrimit = '2 netë'

--2)Selektimi i dhomave me pamje nga Lumbardhi
select *
from LlojiDhomes
where Pamja='Lumbardhi'

--3)Selektimi i pagesave me shume ne mes te 255$ dhe 740$
select *
from Pagesa
where Shuma between 255 and 740
order by Shuma asc

--4)Selektimi i nrShtreterve,Pamjes dhe MaxNjerezve ku dhoma ka kapacitet mbi 4 njerez
select nrShtreterve,Pamja,MaxNjerez
from LlojiDhomes
where MaxNjerez >4

-------------------QUERY TE THJESHTA ME DY OSE ME SHUME TABELA------------------

--1)Selektimi i emrit mbiemrit dhe userlevelit te adminave me userlevel 'Help desk admin'
select d.Emri,d.Mbiemri,a.UserLevel 
from TeDhenat d,Stafi s,Admini a
where d.NrPersonal=s.NrPersonal and a.IdAdmini=s.IdStafi and UserLevel ='Help desk Admin'

--2)Selektimi i emrit dhe mbiemrit te te gjithe mirembajtesave
select td.Emri,td.Mbiemri
from Mirembajtesi m,TeDhenat td,Stafi s
where td.NrPersonal=s.NrPersonal and s.IdStafi=m.IdMirembajtesi 


--3)Selektimi i emrit,mbiemrit te mysafireve te cilet kane perdorur sallen e ngrenjes me nr. te tavolinave 10
SELECT t.emri, t.Mbiemri,h.Kati
FROM Mysafiri m
join TeDhenat t on m.NrPersonal=t.NrPersonal
JOIN HapesiraShtese h ON m.IdHapesira = h.IdHapesira
JOIN SallaNgrenjes s ON h.IdHapesira = s.IdHapesira
where NrTavolinave = 10


--4)Selektimi i emrit, mbiemrit te mysafireve te cilet kane perdorur hapsiren shtese - SPA me jakuzi
select td.Emri,td.Mbiemri
from Mysafiri m
join TeDhenat td on m.NrPersonal=td.NrPersonal
join HapesiraShtese h on m.IdHapesira=h.IdHapesira
join SPA s on h.IdHapesira=s.IdHapesira
where s.Jakuzi = 'Po'

--------------------------QUERY TE AVANCUARA----------------------------

--1)Listimi i sherbyesve qe kane bere sherbimin e porosise "Pije joalkoolike"
select t.Emri,t.Mbiemri, count(*)as NumriPorosive
from Porosia p
join SherbimiPorosise sp on p.LLojiPorosise=sp.LlojiPorosise
join Sherbyesi sh on sh.IdSherbyesi=sp.IdSherbyesi
join Stafi s on sh.IdSherbyesi=s.IdStafi
join TeDhenat t on s.NrPersonal=t.NrPersonal
where sp.LlojiPorosise = 'Pije joalkoolike'
group by t.Emri,t.Mbiemri

--2)Mesatarja e pagesave te bera tek recepsionisti me id 11
select r.IdRecepcionisti, avg(p.Shuma) as ShumaMesatare
from Recepcionisti r
join Pagesa p on r.IdRecepcionisti=p.IdRecepcionisti
group by r.IdRecepcionisti
having r.IdRecepcionisti = '11'

--3)Selektoni te gjithe mysafiret qe kane bere 2 rezervime apo me shume
--Nese i njejti mysafir ka bere dy here rezervime me kohe te qendimit te njejte mos te shfaqet
select distinct m.NrPersonal,t.Emri,t.Mbiemri , datediff(day,r.CheckIn,r.CheckOut) as Koha_e_Qendrimit
from Mysafiri m join Rezervimi r
on r.IdMysafiri=m.IdMysafiri
join TeDhenat t on t.NrPersonal=m.NrPersonal
where datediff(day,r.CheckIn,r.CheckOut) >= 2
order by Koha_e_Qendrimit desc


--4)Shfaq mirembajtesin Ermal Ademi se sa here ka mirembajtur dhomat
select concat(t.Emri,' ',t.Mbiemri)as [Emri dhe mbiemri i mirembajtesit], count(m.IdMirembajtesi)as MirembajturDhomat_X_Here
from MirembajtjaDhomess md
join Dhoma d on d.NrDhomes=md.NrDhomes
join Mirembajtesi m on m.IdMirembajtesi=md.IdMirembajtesi
join Stafi s on s.IdStafi=m.IdMirembajtesi
join TeDhenat t on t.NrPersonal=s.NrPersonal
join LlojiDhomes ld on d.IdLloji=ld.IdLloji
where t.Emri like 'Ermal' and t.Mbiemri like 'Ademi'
group by t.Emri,t.Mbiemri



---------------------SUBQUERY TE THJESHTA---------------------

--1)Te listohet pagesa me shumen e te hollave me te madhe
select *
from Pagesa p
where p.Shuma = (Select max(p.shuma)
				from Pagesa p)

--2)Listoni pagesat me shume me te madhe se mesatarja e te gjitha pagesave
select *
from Pagesa p
join Rezervimi r on r.IdPageses=p.IdPageses
where p.Shuma > (select avg(Shuma)
				from Pagesa)


--3)Emrat e mysafireve qe perdorin hapesira shtese qe ndodhen ne katin e trete
select concat(t.Emri,' ',t.Mbiemri)as [Emri dhe mbiemri i Mysafirit]
from Mysafiri m
join TeDhenat t on t.NrPersonal=m.NrPersonal
join HapesiraShtese h on h.IdHapesira=m.IdHapesira
where h.IdHapesira  in (select h.IdHapesira
						from HapesiraShtese h
						where h.Kati = 3)

--4)Lloji i porosive te bera nga mysafiri me id =2
select concat(t.Emri,' ',t.Mbiemri) [Emri dhe mbiemri i mysafirit],p.LLojiPorosise
from Porosia p
join SherbimiDhomes shd on shd.LlojiPorosise=p.LLojiPorosise
join Mysafiri m on m.IdMysafiri=shd.IdMysafiri
join TeDhenat t on t.NrPersonal=m.NrPersonal
where m.IdMysafiri in (select m.IdMysafiri
						from Mysafiri m
						where m.IdMysafiri = '2')



------------------------SUBQUERY TE AVANCUARA---------------------------------------------
 
--1)Listimi se sa here ka mirembajtur nje mirembajtes dhomat mbi 2 here(PERDORIMI I VIEW)
create view Mirembajtesi_per_dhome as 
select  t.Emri,t.Mbiemri,NrMirembajtjeve = (select count(md.IdMirembajtesi) 
                       from MirembajtjaDhomess md
                       where md.IdMirembajtesi=m.IdMirembajtesi 
						having count(md.IdMirembajtesi)>2
					   )
from Mirembajtesi m
join Stafi s on s.IdStafi=m.IdMirembajtesi
join TeDhenat t on t.NrPersonal=s.NrPersonal

select *
from Mirembajtesi_per_dhome
where NrMirembajtjeve is not null

--2)Selektoni 5 llojet e porosive te cilat jane bere me se shpeshti 
Select top 5 p.LlojiPorosise, COUNT(*) as Numri_I_Porosive
FROM Porosia p ,(select *
				from SherbimiPorosise shp) m
where p.LlojiPorosise = m.LlojiPorosise
GROUP BY p.LlojiPorosise
ORDER BY Numri_I_Porosive DESC

--3)Selektimi i recepsionistit me me se shumti rezervime (PERDORIMI I WITH)
WITH Rezervime_Per_Recepcionist AS (
SELECT r.IdRecepcionisti, COUNT(*) AS Rezervime
FROM Rezervimi r
GROUP BY r.IdRecepcionisti
)
SELECT t.Emri, t.Mbiemri, rpr.Rezervime
FROM Recepcionisti r
JOIN Stafi s ON s.IdStafi = r.IdRecepcionisti
JOIN TeDhenat t ON t.NrPersonal = s.NrPersonal
JOIN Rezervime_Per_Recepcionist rpr ON rpr.IdRecepcionisti = r.IdRecepcionisti
WHERE rpr.Rezervime >= (SELECT MAX(Rezervime) FROM Rezervime_Per_Recepcionist)


--4)Listimi sa here e ka bere nje sherbyes sherbimin e porosise Mengjes ose Dreke ose Darke
select shp.IdSherbyesi , count (p.LLojiPorosise)as nr
from Sherbyesi sh
join SherbimiPorosise shp on shp.IdSherbyesi=sh.IdSherbyesi
join Porosia p on p.LLojiPorosise=shp.LlojiPorosise
where p.LLojiPorosise in (select *
						from Porosia p
						where p.LLojiPorosise='Mengjes' or p.LLojiPorosise='Dreke' or p.LLojiPorosise='Darke')
group by shp.IdSherbyesi

--4.1)Listimi sa here e ka bere nje sherbyes sherbimin e porosise Mengjes ose Dreke ose Darke duke perdorur VIEW

CREATE VIEW V_Porosite_Mengjes_Dreke_Darke AS
SELECT p.LLojiPorosise
FROM Porosia p
WHERE p.LLojiPorosise IN ('Mengjes', 'Dreke', 'Darke');

SELECT shp.IdSherbyesi, COUNT(p.LLojiPorosise) AS nr
FROM Sherbyesi sh
JOIN SherbimiPorosise shp ON shp.IdSherbyesi = sh.IdSherbyesi
JOIN Porosia p ON p.LLojiPorosise = shp.LlojiPorosise
JOIN V_Porosite_Mengjes_Dreke_Darke vmdd ON vmdd.LLojiPorosise = p.LLojiPorosise
GROUP BY shp.IdSherbyesi;

---------------------Algjebra relacionare---------------

--1)Shuma e te gjitha pagave per 1 vjet (PERDORIMI I UNION)
select SUM(Paga)*12 as TotalPaga
from (select Paga from Admini
	union all
	select Paga from Recepcionisti
	union all
	select Paga from Sherbyesi
	union all 
	select Paga from Mirembajtesi)as TotalPaga

--2)Selekto te gjitha dhomat qe kane rezervimin online perveq dhomave me pamje nga Rugova (PERDORIMI I EXCEPT)
select d.IdLloji,d.NrDhomes
from Dhoma d
join RezOnline r
on d.IdRezervimi=r.IdRezervimi
join LlojiDhomes l
on l.IdLloji=d.IdLloji
except
select d.IdLloji,d.NrDhomes
from Dhoma d
join LlojiDhomes l
on d.IdLloji=l.IdLloji
where l.Pamja = 'Rugova'

--3)Selektimi i mysafireve te cilet kohen e qendrimit e kane 3 netë dhe kanë perdorur haspirën shtesë Spa e cila ka jakuzi(PERDORIMI I INTERSECT)
select t.Emri,t.Mbiemri
from Mysafiri m
join TeDhenat t on t.NrPersonal=m.NrPersonal
join Rezervimi r on r.IdMysafiri=m.IdMysafiri
where r.KohaQendrimit = '3 netë'
intersect
select t.Emri,t.Mbiemri
from Mysafiri m
join TeDhenat t on t.NrPersonal=m.NrPersonal
join HapesiraShtese h on h.IdHapesira=m.IdMysafiri
join SPA s on s.IdHapesira=h.IdHapesira
where s.Jakuzi = 'Po'

--4)Selektoni te gjithe mysafiret qe kane bere rezervimin fizik dhe kane perdorur hapsirenShtese ne katin e pare perveq atyre mysafireve qe kane perdorur menyren e pageses cash
select m.NrPersonal, t.Emri, t.Mbiemri
from Mysafiri m
join TeDhenat t on t.NrPersonal=m.NrPersonal
join Rezervimi r on r.IdMysafiri=m.IdMysafiri
join RezFizik rf on rf.IdRezervimi=r.IdRezervimi
intersect
SELECT m.NrPersonal, t.Emri, t.Mbiemri
FROM Mysafiri m
join TeDhenat t on t.NrPersonal=m.NrPersonal
WHERE IdHapesira IN (SELECT IdHapesira FROM HapesiraShtese WHERE Kati =1)
EXCEPT
SELECT m.NrPersonal, t.Emri, t.Mbiemri
FROM Pagesa p
join Mysafiri m on m.IdMysafiri=p.IdPageses
join TeDhenat t on t.NrPersonal=m.NrPersonal
WHERE Menyra = 'Cash'

-------------------------STORED PROCEDURES------------------

--1)Procedure e ruajtur e cila liston te gjithe recepsionistet varesisht nga inputat dhe poashtu tregon numrin e rezervimeve per recepsionist(PERDORIMI I WHILE)
CREATE PROCEDURE getRecepsionistet (@startId int, @endId int)
AS
BEGIN
DECLARE @currentId INT
SET @currentId = @startId
WHILE @currentId <= @endId
BEGIN
    SELECT t.emri, t.mbiemri,  (SELECT COUNT(*) 
								FROM Rezervimi r
								join Recepcionisti rr on rr.IdRecepcionisti=r.IdRecepcionisti
								WHERE rr.IdRecepcionisti = @currentId) AS [Numri i Rezervimeve]
    FROM Stafi s 
    JOIN TeDhenat t ON t.NrPersonal = s.NrPersonal
    WHERE s.IdStafi = @currentId

    SET @currentId = @currentId + 1
END
END

exec getRecepsionistet 11,23


--2)Procedure e ruajtur e cila tregon se cilet mysafire kane perdorur haspiren shtese ne katin e dhene si input (PERDORIMI I CASE)
CREATE PROCEDURE Get_Mysafir_Kati_Dynamic (@Kati INT)
AS
BEGIN
SELECT CONCAT(t.Emri, ' ', t.Mbiemri) AS [Emri dhe mbiemri i Mysafirit], h.Kati
FROM Mysafiri m
JOIN TeDhenat t ON t.NrPersonal = m.NrPersonal
JOIN HapesiraShtese h ON h.IdHapesira = m.IdHapesira
WHERE h.Kati = CASE
WHEN @Kati IS NOT NULL THEN @Kati
ELSE h.Kati
END;
END

exec Get_Mysafir_Kati_Dynamic 3

--2.1)Procedure e ruajtur e cila tregon se cilet mysafire kane perdorur haspiren shtese ne katin e dhene si input (DUKE PERDORUR IF_ELSE)
CREATE PROCEDURE Get_Mysafir_Kati_Dynamicc (
@Kati INT out
)
AS
BEGIN
IF (@Kati IS NOT NULL)
BEGIN
SELECT CONCAT(t.Emri, ' ', t.Mbiemri) AS [Emri dhe mbiemri i Mysafirit], h.Kati
FROM Mysafiri m
JOIN TeDhenat t ON t.NrPersonal = m.NrPersonal
JOIN HapesiraShtese h ON h.IdHapesira = m.IdHapesira
WHERE h.Kati = @Kati;
END
ELSE
BEGIN
PRINT 'TE GJITHE MYSAFIRET NE TE GJITHA KATET'
SELECT CONCAT(t.Emri, ' ', t.Mbiemri) AS [Emri dhe mbiemri i Mysafirit], h.Kati
FROM Mysafiri m
JOIN TeDhenat t ON t.NrPersonal = m.NrPersonal
JOIN HapesiraShtese h ON h.IdHapesira = m.IdHapesira;
END;
END

exec Get_Mysafir_Kati_Dynamicc null

--3)Procedure e ruajtur qe tregon sa here eshte bere nje sherbim i caktuar sipas inputit(DUKE PERDORUR IF-ELSE)
CREATE PROCEDURE NumeroSherbimet (@Sherbimi VARCHAR(50))
AS
BEGIN
    DECLARE @Count INT = 0
    
    SELECT @Count = COUNT(*)
    FROM SherbimiPorosise s
    WHERE s.LlojiPorosise = @Sherbimi
    
    IF (@Count > 0)
    BEGIN
        PRINT 'Numri i sherbimeve ' + @Sherbimi + ' eshte bere: ' + CAST(@Count AS VARCHAR(10))
    END
    ELSE
    BEGIN
        PRINT 'Asnje sherbim te tipit ' + @Sherbimi + ' nuk u gjet.'
    END
END

exec NumeroSherbimet Mengjes

--4)Procedure e cila ruan se sa rezervime jane bere (DUKE PERDORUR IF-ELSE)
CREATE PROCEDURE Numero_Rezervimet
as
BEGIN
DECLARE @count INT;

SELECT @count = COUNT(*)
FROM Rezervimi r 
JOIN Mysafiri m ON m.IdMysafiri=r.IdMysafiri

IF (@count >0)
begin
	print 'Rezervimet totale: ' + CAST(@count AS VARCHAR(10));
	end
ELSE
begin
    print 'Nuk eshte gjetur asnje rezervim.'
END
END

exec Numero_Rezervimet

--KLEA KASAPOLLI PJESA TRETË
--4 query te thjeshta
--Listoni datat dhe id e pagesave te kryera cash.
select DataPageses,IdPageses,Menyra
from Pagesa
where Menyra like 'Cash'

--Listoni rezervimet qe jane bere para dates 12 janar 2023 nga recepcionisti me id 11.
select *
from Rezervimi
where IdRecepcionisti=11 and CheckIn < '2023/01/12'

--Listoni emrin, mbiemrin, dhe moshen e secilit mysafir dhe pjesetar te stafit,nga me i moshuari.
select Emri,Mbiemri,DATEDIFF(year,DataLindjes,GETDATE()) as Mosha
from TeDhenat
order by Mosha desc

--Listo moshen me te madhe nga secili qytet nese qyteti nuk eshte null
select td.Qyteti,max(DATEDIFF(year,td.DataLindjes,getdate())) as Mosha
from TeDhenat td inner join Stafi s
on td.NrPersonal=s.NrPersonal
where td.Qyteti is not null 
group by td.Qyteti         
	


-- 4 query te thjeshta ne minimum dy relacione

--Listoni pagesat qe jane kryer nga recepcionistja Rona Bala
select p.IdPageses, p.Menyra,p.Shuma,p.DataPageses, td.Emri,td.Mbiemri
from TeDhenat td inner join Stafi s
on td.NrPersonal=s.NrPersonal inner join Pagesa p
on s.IdStafi=p.IdRecepcionisti
where td.Emri='Rona' and td.Mbiemri='Bala'

--Listoni id dhe katin e hapesirave qe nuk mirembahen nga mirembajtesit
select hs.IdHapesira, hs.Kati,m.IdMirembajtesi
from Mirembajtesi m right join HapesiraShtese hs
on m.IdHapesira=hs.IdHapesira
where m.IdHapesira is null

--Listo dhomat me saune dhe tv
select dh.NrDhomes, 'Po'[Sauna + TV], lldh.IdLloji
from Dhoma dh inner join LlojiDhomes lldh
on dh.IdLloji=lldh.IdLloji
where lldh.Sauna<>'Jo' and lldh.TV<>'Jo'

--Listoni te gjitha rezervimet e bera nga mysafiret me id midis 1 dhe 4. Te shfaqen emrat dhe mbiemrat e ketyre mysafireve.
select r.IdRezervimi,r.IdRecepcionisti,r.IdPageses,r.KohaQendrimit,r.CheckIn,r.CheckOut,m.IdMysafiri,concat(td.Emri,' ',td.Mbiemri)as Mysafiri
from Rezervimi r inner join Mysafiri m
on r.IdMysafiri=m.IdMysafiri inner join TeDhenat td
on m.NrPersonal=td.NrPersonal
where m.IdMysafiri between 1 and 4




--Query te avancura 

--Listo sallat e ngrenies dhe katin e tyre qe kane numer me te madh te karrikave sesa numri maksimal i tavolinave

select sn.IdHapesira
from SallaNgrenjes sn inner join HapesiraShtese hs
on sn.IdHapesira=hs.IdHapesira 
group by sn.IdHapesira,sn.NrKarrigeve
having sn.NrKarrigeve>max(sn.NrTavolinave)
	
--Listo recepcionistet qe kane pranuar me shume se 2 pagesa, shfaq moshen e tyre poashtu.
select td.Emri,td.Mbiemri,count(p.IdPageses)[Numri i pagesave],(datediff(year,td.DataLindjes,GETDATE()))as Mosha
from Recepcionisti r inner join Stafi s
on r.IdRecepcionisti=s.IdStafi inner join TeDhenat td
on s.NrPersonal=td.NrPersonal inner join Pagesa p
on s.IdStafi=p.IdRecepcionisti
group by td.Emri,td.Mbiemri,td.DataLindjes
having count(p.IdPageses)>2 

--numero rezervimet online te kryera nga recepcionistet Vatan Haxhia,Agon Bytyqi dhe Erdi Sadiku, per dhomat me pamje nga Rugova 

select concat(td.Emri,' ',td.Mbiemri)[Emri dhe Mbiemri],rezo.IdRezervimi,d.NrDhomes,lld.Pamja
from TeDhenat td inner join Stafi s
on td.NrPersonal=s.NrPersonal inner join Recepcionisti r
on r.IdRecepcionisti=s.IdStafi inner join Rezervimi rez
on r.IdRecepcionisti=rez.IdRecepcionisti inner join RezOnline rezo
on rez.IdRezervimi=rezo.IdRezervimi inner join Dhoma d
on d.IdRezervimi=rezo.IdRezervimi inner join LlojiDhomes lld
on d.IdLloji=lld.IdLloji
where (td.Emri='Vatan' and td.Mbiemri='Haxhia') or (td.Emri='Erdi' and td.Mbiemri='Sadiku')or(td.Emri='Agon' and td.Mbiemri='Bytyqi') and lld.Pamja='Rugove' 
	

--Listo shumen e pagesave te kryera nga mysafiret mbi 21 vjec. Paraqit emrin, mbiemrin dhe moshen e mysafirit.
select  m.IdMysafiri,sum(p.Shuma)[Shuma e pagesave],DATEDIFF(year,td.DataLindjes,getdate())as Mosha,CONCAT(td.Emri,' ',td.Mbiemri)[Mysafiri]
from Mysafiri m inner join Tedhenat td 
on m.NrPersonal=td.NrPersonal inner join Rezervimi r
on m.IdMysafiri=r.IdMysafiri inner join Pagesa p
on r.IdPageses=p.IdPageses 
where DATEDIFF(year,td.DataLindjes,getdate())>21
group by m.IdMysafiri,DATEDIFF(year,td.DataLindjes,getdate()),CONCAT(td.Emri,' ',td.Mbiemri)


--Listo mysafiret qe kane bere dy rezervime. Te shfaqet id e mysafirit dhe numri personal.
select m.IdMysafiri,m.NrPersonal, count(r.IdRezervimi)[Numri i rezervimeve ]
from Mysafiri m inner join Rezervimi r
on m.IdMysafiri=r.IdMysafiri
group by m.IdMysafiri,m.NrPersonal
having count(r.IdRezervimi)=2

	
-- 4 subquery te thjeshta
--Te listohen spa me me se paku pishina
select *
from SPA spa
where spa.NrPishinave=(select min(spa.NrPishinave)from SPA spa)

--Te listohen te dhenat e adminit qe posedon kartelen speciale me id me te madhe
select *
from TeDhenat td inner join Stafi s
on td.NrPersonal=s.NrPersonal inner join Admini a
on s.IdStafi=a.IdAdmini
where a.IdKartela in (select max(a.IdKartela) from Admini a)

--Te listohen pjesetaret e stafit qe kane pagen me te madhe se mesatarja e pages se te gjithe stafit
select *
from Stafi s inner join Admini a
on s.IdStafi=a.IdAdmini
where a.Paga>(select avg(a.paga)from Admini a )

--Te listohet se nga cili qytet ka me shume mysafire dhe staf, si dhe numrin e tyre
--Te paraqitet edhe zip kodi i qytetit 
select td.Qyteti,count(td.Qyteti)[Numri i stafit dhe mysafireve],td.ZipKodi
from TeDhenat td
group by td.Qyteti,td.ZipKodi
having count(td.Qyteti)>=ALL(select count(td.Qyteti)
from TeDhenat td
group by td.Qyteti)


--Subquery te avancuara

--Listo mysafiret qe kane qendruar ne hotel me shume se mesatarja e kohes se qendrimit.
--Te tregohet emri, mbiemri dhe nr personal i mysafirit si dhe id e recepcionistit qe ka pranuar rezervimin.
select m.IdMysafiri,td.Emri,td.Mbiemri,m.NrPersonal, datediff(day,r.CheckIn,r.CheckOut)[Koha e qendrimit],rec.IdRecepcionisti
from Mysafiri m inner join TeDhenat td 
on m.NrPersonal=td.NrPersonal inner join Rezervimi r
on m.IdMysafiri=r.IdMysafiri inner join Recepcionisti rec
on r.IdRecepcionisti=rec.IdRecepcionisti 
where datediff(day,r.CheckIn,r.CheckOut)>(select avg(datediff(day,r.CheckIn,r.CheckOut))
from Rezervimi r
)


-- Te listohen llojet e dhomave me me pak shtreter se sa mesatarja e te gjithe shtreterve.

select ld.IdLloji
from LlojiDhomes ld,(select avg(ld.nrShtreterve) as avgSh from LlojiDhomes ld)subquery1
where ld.nrShtreterve <subquery1.avgSh

--Te listohen pagesat e pranuara mbi mesataren e te gjitha pagesave cash. Te shfaqet shuma e pageses,id e pageses,menyra e pageses
--emri,mbiemri dhe id e recepcionistit qe i ka pranuar ato

with avg_Pageses as
           (select avg(p.Shuma) as a_p
			from Pagesa p
			where p.Menyra ='Cash'
			)
select r.IdRecepcionisti,concat(td.Emri,' ',td.Mbiemri)as Recepcionisti,p.Shuma,p.IdPageses,p.Menyra
from avg_Pageses,Recepcionisti r inner join Stafi s
on r.IdRecepcionisti=s.IdStafi inner join TeDhenat td
on s.NrPersonal=td.NrPersonal inner join Pagesa p
on s.IdStafi=p.IdRecepcionisti
where p.Shuma>a_p
	

--Te listohen pagat e mirembajtesve qe jane me te vogla se minimumi i pages se sherbyesve qe kane sherbyer porosi higjienike ose mengjes.
--Te shfaqen emri,mbiemri, si dhe numri i personal i mirembajtesve
select concat(td.Emri,' ',td.Mbiemri)as Mirembajtesi,td.NrPersonal,m.Paga
from TeDhenat td inner join Stafi s
on td.NrPersonal=s.NrPersonal inner join Mirembajtesi m
on s.IdStafi=m.IdMirembajtesi
where m.Paga<(select min(sh.Paga)
	        from Sherbyesi sh inner join SherbimiPorosise shp
			  on sh.IdSherbyesi=shp.IdSherbyesi
			  where shp.LlojiPorosise in('Higjiene','Mengjes'))


--te listohen dhomat qe posedojne wifi dhe qe akomodojne me pak ose sa mesatarja e maksimumit te njerezve
--te te gjitha llojet e dhomave. Te shfaqet id e llojit te dhomes, max i njerezve qe lejohet ne ate lloj dhome,
--numri i dhomes si dhe mirembajtesit qe i mirembajne ato dhoma.
create view DhomaWiFi as
	select ld.IdLloji,ld.MaxNjerez
	from LlojiDhomes ld
	where ld.WiFi='Po'

select sw.IdLloji,ld.MaxNjerez,d.NrDhomes,ld.WiFi,concat(tdh.Emri,' ',tdh.Mbiemri)as Mirembajtesi
from LlojiDhomes ld inner join DhomaWiFi sw
on ld.IdLloji=sw.IdLloji inner join Dhoma d
on ld.IdLloji=d.IdLloji inner join MirembajtjaDhomess mdh
on d.NrDhomes=mdh.NrDhomes inner join Stafi s
on s.IdStafi=mdh.IdMirembajtesi inner join TeDhenat tdh
on s.NrPersonal=tdh.NrPersonal
where sw.MaxNjerez<=(select avg(ld.MaxNjerez)
	                 from LlojiDhomes ld)



-- 4 query/subquery me union,prerje,diference

--Te listohet stafi qe eshte edhe recepcionist edhe sherbyes.Te paraqitet emri,mbiemri dhe numri personal
select tdh.Emri,tdh.Mbiemri,s.NrPersonal
from Recepcionisti rec inner join Stafi s
on rec.IdRecepcionisti=s.IdStafi inner join TeDhenat tdh
on s.NrPersonal=tdh.NrPersonal 
	
intersect

select tdh.Emri,tdh.Mbiemri,s.NrPersonal
from Sherbyesi sh inner join Stafi s
on sh.IdSherbyesi=s.IdStafi inner join TeDhenat tdh
on s.NrPersonal=tdh.NrPersonal

--Te listohen personat qe jane te regjistruar me numer personal,emer,mbiemer,email dhe date te lindjes por jo 
--edhe me qytet,rruge dhe zip kod

select *
from TeDhenat
where emri is not null and Mbiemri is not null and email is not null and DataLindjes is not null

except 

select*
from TeDhenat
where qyteti is not null and rruga is not null and ZipKodi is not null

--Selektimi i admineve me page me te madhe se mesatarja dhe i mysafireve qe kane lindur gjate muajit maj
select td.Emri,td.Mbiemri,td.DataLindjes
from Admini a inner join Stafi s
on a.IdAdmini=s.IdStafi inner join TeDhenat td
on s.NrPersonal=td.NrPersonal
where a.Paga>(select avg(a.Paga)
               from Admini a)

			   union
select td.Emri,td.Mbiemri,td.DataLindjes
from Mysafiri m inner join TeDhenat td
on m.NrPersonal=td.NrPersonal
where td.DataLindjes like '%-05-%'

--Selektimi i te gjitha rezervimeve me pagese me te vogel se cilado page e mirembajtesve pervec rezervimeve me check-in dite 04 
select r.IdRezervimi,r.KohaQendrimit
from Rezervimi r inner join Pagesa p
on r.IdPageses=p.IdPageses
where p.Shuma<any(select m.Paga
                from Mirembajtesi m)		   
except

select r.IdRezervimi,r.KohaQendrimit
from Rezervimi r
where r.CheckIn like '%-04%'


--4 stored procedures

--Procedure e ruajtur e cila tregon se cili recepsionist ka bere rezervimin per cilen dhome varsisht nga inputat
create procedure GetReceptionistName (@ReceptionistNamee varchar(50), @RoomNumber int)
as
begin
    select r.IdRecepcionisti , d.NrDhomes
    from Rezervimi r
    inner join Dhoma d
    on r.IdRezervimi=d.IdRezervimi
    join Recepcionisti rr
    on rr.IdRecepcionisti=r.IdRecepcionisti
    join stafi s 
    on s.IdStafi=rr.IdRecepcionisti
    join TeDhenat t
    on t.NrPersonal=s.NrPersonal
    where (@ReceptionistNamee is null or t.Emri = @ReceptionistNamee)
    AND (@RoomNumber is null or d.NrDhomes= @RoomNumber)
end
 
exec GetReceptionistName 'Arben' ,202



--Procedure e ruajtur qe tregon shumen e pagesave te kryera nga mysafiret mbi moshen qe jepet ne input
create procedure getPaymentSum (@Age int)
as
begin
	if @Age is not null
	begin
	select distinct m.IdMysafiri,sum(p.Shuma)[Shuma e pagesave],DATEDIFF(year,td.DataLindjes,getdate())as Mosha,CONCAT(td.Emri,' ',td.Mbiemri)[Mysafiri]
	from Mysafiri m inner join Tedhenat td 
	on m.NrPersonal=td.NrPersonal inner join Rezervimi r
	on m.IdMysafiri=r.IdMysafiri inner join Pagesa p
	on r.IdPageses=p.IdPageses 
	where DATEDIFF(year,td.DataLindjes,getdate())>@Age
	group by m.IdMysafiri,DATEDIFF(year,td.DataLindjes,getdate()),CONCAT(td.Emri,' ',td.Mbiemri)
end
else
begin
select distinct m.IdMysafiri,sum(p.Shuma)[Shuma e pagesave],DATEDIFF(year,td.DataLindjes,getdate())as Mosha,CONCAT(td.Emri,' ',td.Mbiemri)[Mysafiri]
	from Mysafiri m inner join Tedhenat td 
	on m.NrPersonal=td.NrPersonal inner join Rezervimi r
	on m.IdMysafiri=r.IdMysafiri inner join Pagesa p
	on r.IdPageses=p.IdPageses
	group by m.IdMysafiri,DATEDIFF(year,td.DataLindjes,getdate()),CONCAT(td.Emri,' ',td.Mbiemri)
	end
	end

exec getPaymentSum 21

--Procedure e ruajtur qe tregon emrin e dhomes ne baze te id-se 
create proc getEmriDhomes

@llojiDhomes int,
@nrDhomes varchar(30) out,
@emriDhomes varchar(30) out

as
begin 
select @nrDhomes=NrDhomes,@emriDhomes=(case 
when @llojiDhomes=1 then 'Standard'
when @llojiDhomes=2 then 'Deluxe Twin'
when @llojiDhomes=3 then 'Deluxe'
when @llojiDhomes=4 then 'Presidential'
when @llojiDhomes=5 then 'Penthouse'
when @llojiDhomes=6 then 'Standard+'
when @llojiDhomes=7 then 'Deluxe Twin+'
when @llojiDhomes=8 then 'Deluxe+'
when @llojiDhomes=9 then 'Presidential+'
when @llojiDhomes=10 then 'Penthouse+'
else null
end)
from LlojiDhomes ld inner join Dhoma d
on ld.IdLloji=d.IdLloji
where ld.IdLloji=@llojiDhomes
if(@llojiDhomes is not null)
   begin
   print 'Dhoma me numer '+@nrDhomes+' quhet '+@emriDhomes
   end

else
   begin
   print 'Ky lloj i dhomes nuk ekziston'
   end
end

declare @nrD varchar(30),@eD varchar(30)
exec getEmriDhomes 2,
@nrDhomes=@nrD out,
@emriDhomes=@eD out	

--Procedure e ruajtur qe tregon sa dhoma kane sa shtreter
create procedure countRooms
as 
begin
declare @counter int
declare @maxShtreter int
declare @numDhomave int

set @maxShtreter=(select max(ld.nrShtreterve)from LlojiDhomes ld)
set @counter=0

while @counter<=@maxShtreter
begin
set @numDhomave=
    (select count(*)from LlojiDhomes ld where ld.nrShtreterve=@counter)

	print cast(@numDhomave as varchar(3))+' dhoma kane '+
	cast(@counter as varchar(2))+' shtreter'

	set @counter=@counter+1
end
end

exec countRooms
