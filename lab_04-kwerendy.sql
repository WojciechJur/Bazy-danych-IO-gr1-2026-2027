 #zad1
 show create table pracownik;
 show create table projekt;
 show create table zadanie;
 
alter table zadanie drop foreign key fk_zadanie_pracownik;
alter table projekt drop foreign key fk_projekt_menadzer;

alter table pracownik modify id_pracownika INT;
alter table pracownik drop primary key;

alter table pracownik modify id_pracownika int auto_increment primary key;

alter table zadanie
add constraint fk_zadanie_pracownik foreign key (pracownik)
references pracownik(id_pracownika)
on delete set null;

alter table projekt add constraint fk_projekt_menadzer foreign key (menadżer_projektu) references pracownik(id_pracownika);

#zad2
alter table zadanie add column godziny_szacowane int default 8;

update zadanie set godziny_szacowane = 4 where id_zadania = 1;
update zadanie set godziny_szacowane = 12 where id_zadania = 2;
update zadanie set godziny_szacowane = 16 where id_zadania = 3;

alter table zadanie modify column godziny_szacowane int default 6;

insert into zadanie (nazwa_zadania, priorytet, opis)
values ('zadanie testowe','normalny','Opis testowy');

select id_zadania, nazwa_zadania, godziny_szacowane from zadanie
where nazwa_zadania = 'zadanie testowe';

delete from zadanie where nazwa_zadania = 'Zadanie testowe';

#zad3
alter table projekt add column opis_kratki varchar(50);

alter table projekt modify column opis_kratki varchar(200);

update projekt set opis_kratki = 'MVP' where id_projektu = 1;
update projekt set opis_kratki = 'pilne wdrożenie' where id_projektu = 2;

alter table projekt drop column opis_kratki;

#zad4
alter table zadanie drop foreign key fk_zadanie_projekt;

alter table zadanie add constraint fk_zadanie_projekt foreign key (projekt)
references projekt(id_projektu)
on delete set null;

delete from projekt where id_projektu = 1;

select id_zadania, nazwa_zadania, projekt from zadanie;