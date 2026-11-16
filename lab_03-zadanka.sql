#zad1
pracownik CREATE TABLE pracownik (
id_pracownika INT auto_increment PRIMARY KEY,
imie varchar(40) not null,
nazwisko varchar(60) not null,
data_urodzenia DATE not null);

insert into pracownik (imie, nazwisko, data_urodzenia) values
('Jan','Kowa','1985-05-12'),
('Anna','Nowak','1990-08-23'),
('Piotr','Zieliński','1992-11-04');

update pracownik set data_urodzenia = '1985-05-15' where id_pracownika = 1;

#zad2
create table zadanie (
id_zadania INT auto_increment primary key,
nazwa_zadania varchar(150) not null,
priorytet Enum('normalny','wysoki','niski'),
opis text,
pracownik int,
constraint fk_zadanie_pracownik foreign key (pracownik)
references pracownik(id_pracownika)
on delete set null);

alter table zadanie modify column priorytet ENUM('normalny','wysoki','niski') default 'normalny';

insert into zadanie (nazwa_zadania, priorytet, opis, pracownik) Values
('Analiza wymagań systemowych','wysoki','Szczegółowa analiza',1),
('projektowanie bazy danych','normalny','Stworzenie modelu relacyjnego',2),
('testy jednostkowe','niski','przeprowadzenie testu kodu',3);

#zad3

create table projekt (
id_projektu int auto_increment primary key,
nazwa_projektu varchar(150),
data_rozpoczencia date,
data_zakonczenia date);

alter table projekt
add column menadżer_projektu int,
add constraint fk_projekt_menadzer foreign key (menadżer_projektu)
references pracownik(id_pracownika);

insert into projekt (nazwa_projektu, data_rozpoczencia, data_zakonczenia, menadżer_projektu) values
('System CRM','2026-01-10','2026-06-30',1),
('sklep internetowy','2026-03-01', null,2);

alter table zadanie
add column projekt int,
add constraint fk_zadanie_projekt foreign key (projekt)
references projekt(id_projektu)
on delete cascade;

update zadanie set projekt = 1 where id_zadania in (1, 2);
update zadanie set projekt = 2 where id_zadania = 3;

#zad4
create table sprint (
id_sprintu int auto_increment primary key,
numer_sprintu int unsigned,
data_rozpoczencia date,
data_zakonczenia date);

alter table zadanie
add column sprint int,
add constraint fk_zadanie_sprint foreign key (sprint)
references sprint(id_sprintu)
on delete set null;

insert into sprint (numer_sprintu, data_rozpoczencia, data_zakonczenia)
values (1, '2026-03-01', '2026-03-14');

update zadanie set sprint = 1 where id_zadania in (1,2);

#zad5
create table status (
id_statusu int auto_increment primary key,
nazwa_statusu varchar(20));

insert into status (nazwa_statusu) values
('nowe'),
('w toku'),
('zakończone');

create table zadanie_has_status (
id_zdarzenia int auto_increment primary key,
id_zadania int,
id_statusu int,
data_zdarzsenia datetime default current_timestamp,
constraint fk_zhs_zadanie foreign key (id_zadania) references zadanie(id_zadania),
constraint fk_zhs_status foreign key (id_statusu) references status(id_statusu));

insert into zadanie_has_status (id_zadania, id_statusu) values
(1,1),
(2,2),
(3,3);

delete from projekt where id_projektu = 2;

alter table zadanie drop foreign key fk_zadanie_sprint;
alter table zadanie drop column sprint;

