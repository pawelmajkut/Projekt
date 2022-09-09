--WERSJA FINALNA SKLEP INTERNETOWY BAJT
USE master;
GO
IF DB_ID (N'SklepInternetowy_BAJT') IS NOT NULL
DROP DATABASE SklepInternetowy_BAJT;

CREATE DATABASE SklepInternetowy_BAJT COLLATE Polish_100_CI_AS;

GO
IF DB_ID (N' SklepInternetowy_BAJT') IS NOT NULL
SELECT 'Database correctly created!';

--Tworzenie tabel
USE [SklepInternetowy_BAJT]

CREATE TABLE [dbo].[Kategorie](
	[ID_kategorie] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL
)

CREATE TABLE [dbo].[Producent](
	[ID_producent] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL
	
)

CREATE TABLE [dbo].[Pracownicy](
	[ID_pracownicy] [int] PRIMARY KEY IDENTITY,
	[Imię] [nvarchar] (250) NOT NULL,
	[Nazwisko] [nvarchar] (250) NOT NULL,
	[Stanowisko] [nvarchar] (250) NOT NULL,
	[PESEL] [nvarchar] (11) NOT NULL
	)

CREATE TABLE [dbo].[Opiekun_produktu](
	[ID_opiekun] [int] PRIMARY KEY IDENTITY,
[PracownicyID] [int] FOREIGN KEY REFERENCES Pracownicy(ID_pracownicy),
[ProducentID] [int] FOREIGN KEY REFERENCES Producent(ID_producent)
)


CREATE TABLE [dbo].[Produkty](
	[ID_produkty] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL,
	[Opis] [nvarchar] (250),
	[ProducentID] [int] FOREIGN KEY REFERENCES Producent(ID_producent),
	[KategoriaID] [int] FOREIGN KEY REFERENCES Kategorie(ID_kategorie),
	[Ilość] [int] NOT NULL,
	[Cena] [decimal] (8,2) NOT NULL,
[OpiekunProduktuID] [int] FOREIGN KEY REFERENCES Opiekun_produktu(ID_opiekun)  
	
)

CREATE TABLE [dbo].[Klienci](
	[ID_klienci] [int] PRIMARY KEY IDENTITY,
	[Imię] [nvarchar] (250) NOT NULL,
	[Nazwisko] [nvarchar] (250) NOT NULL,
[Data_urodzenia] [datetime] NOT NULL,
	[Adres_zam] [nvarchar] (250) NOT NULL,
	[Kod_pocztowy] [nvarchar] (250) NOT NULL,
	[Email] [nvarchar] (250) NOT NULL,
	[Tel_kom] [nvarchar] (20) NOT NULL
)

CREATE TABLE [dbo].[Statusy](
	[ID_statusy] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL
)

CREATE TABLE [dbo].[Dostawa](
[ID_dostawa] [int] PRIMARY KEY IDENTITY,
[Dostawca] [nvarchar] (250) NOT NULL,
[Rodzaj_dostawy] [nvarchar] (250) NOT NULL,
[Cena_dostawy] [decimal] (8,2) NOT NULL,
)

CREATE TABLE [dbo].[Koszyk](
	[ID_koszyka] [int] PRIMARY KEY IDENTITY,
[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID_klienci),
[Data_zamówienia] [datetime] NOT NULL,
[Kwota_razem] [decimal] (8,2) NOT NULL,
[StatusID] [int] FOREIGN KEY REFERENCES Statusy(ID_statusy),
[Rabat] [int] CHECK ([Rabat] IN (0,5,10,15,20) ) DEFAULT 0,
[DostawaID] [int] FOREIGN KEY REFERENCES Dostawa(ID_dostawa),
[Data_dostawy] [datetime] NOT NULL,
[Status_płatnościID] [int] FOREIGN KEY REFERENCES Statusy(ID_statusy)
)

CREATE TABLE [dbo].[Wybrane_produkty](
[ID_zamowienia] [int] PRIMARY KEY IDENTITY,
[produktID] [int] FOREIGN KEY REFERENCES Produkty(ID_produkty),
[Ilość] [int] NOT NULL,
[Suma] [decimal] (8,2),
[StatusID] [int] FOREIGN KEY REFERENCES Statusy(ID_statusy),
[koszykID] [int] FOREIGN KEY REFERENCES Koszyk(ID_koszyka),
[Rabat] [int] CHECK ([Rabat] IN (0,5,10,15,20) ) DEFAULT 0
)


CREATE TABLE [dbo].[Rezerwacje_produktów](
	[ID_rezerwacje] [int] PRIMARY KEY IDENTITY,
	[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID_klienci),
	[ProduktID] [int] FOREIGN KEY REFERENCES Produkty(ID_produkty),
	[StatusID] [int] FOREIGN KEY REFERENCES Statusy(ID_statusy),
	[Data_konca_rezerwacji] [datetime] NOT NULL
)  

CREATE TABLE [dbo].[Rabaty](
	[ID_rabaty] [int] PRIMARY KEY IDENTITY,
	[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID_klienci),
	[Procent] [int] CHECK ([Procent] IN (5,10,15,20) ) DEFAULT 5
)
--- koniec tworzenia tabel
--------------------------------------
-- wypełnianie bazy danych danymi -----
--------------------------------------
--- utworzenie klientów

USE [SklepInternetowy_BAJT]
INSERT INTO Klienci(Imię, Nazwisko, Data_urodzenia, Adres_zam, Kod_pocztowy, Email, Tel_kom) VALUES
('Diego','Mróz','1977-06-28','ul. Morcinka Gustawa 17, Warszawa','01-496','Diego.Mróz@gmail.com','775562735'),
('Kacper','Jasińska','1988-11-15','ul. Syrokomli Władysława 113, Szczecin','71-145','Kacper.Jasińska@gmail.com','286259512'),
('Lucjan','Mazurek','1998-09-15','ul. Traugutta Romualda 86, Koszalin','75-568','Lucjan.Mazurek@gmail.com','556765118'),
('Olaf','Baranowska','1991-10-28','ul. Remontowa 88, Warszawa','03-616','Olaf.Baranowska@gmail.com','658396514'),
('Radosław','Nowak','1986-04-08','ul. Wolności 25, Mierzęcice','42-460','Radosław.Nowak@gmail.com','344093480'),
('Janusz','Kaczmarczyk','1968-05-28','ul. Łodzianka 106, Łódź','91-527','Janusz.Kaczmarczyk@gmail.com','973883751'),
('Joachim','Jankowska','1993-08-03','ul. Skrzetuskiego 82, Lublin','20-628','Joachim.Jankowska@gmail.com','146192423'),
('Natan','Wiśniewska','1985-06-15','ul. Gaj 43, Brzeg','49-304','Natan.Wiśniewska@gmail.com','479083240'),
('Oktawian','Kozłowska','1994-03-23','Al. Jana Pawła II 98, Radzymin','05-250','Oktawian.Kozłowska@gmail.com','733403043'),
('Aureliusz','Zakrzewska','2003-07-30','ul. Seminaryjna 22, Bydgoszcz','85-326','Aureliusz.Zakrzewska@gmail.com','445193912'),
('Mirosław','Makowska','1979-03-23','ul. Dworkowa 127, Poznań','60-602','Mirosław.Makowska@gmail.com','771972336'),
('Mariusz','Kozłowska','1984-05-21','ul. Promienna 137, Łódź','91-504','Mariusz.Kozłowska@gmail.com','843543469'),
('Adrian','Woźniak','2000-11-12','ul. Chorwacka 120, Bydgoszcz','85-162','Adrian.Woźniak@gmail.com','652872377'),
('Dobromił','Szczepańska','1972-08-30','ul. Kłosowa 67, Tarnowskie Góry','42-605','Dobromił.Szczepańska@gmail.com','557658358'),
('Adam','Czarnecka','1978-02-16','ul. Żelazna 38, Kielce','25-014','Adam.Czarnecka@gmail.com','389023006'),
('Kajetan','Szymczak','1993-02-23','ul. Drewniana 91, Lublin','20-305','Kajetan.Szymczak@gmail.com','512370327'),
('Emanuel','Kowalczyk','1973-01-29','ul. Macierzanki 3, Lublin','20-834','Emanuel.Kowalczyk@gmail.com','995234914'),
('Jędrzej','Maciejewska','1979-03-17','ul. Kazubów 17, Warszawa','01-466','Jędrzej.Maciejewska@gmail.com','610349752'),
('Bartosz','Zawadzka','1973-02-07','ul. Nowiniarska 15, Warszawa','00-235','Bartosz.Zawadzka@gmail.com','888901638'),
('Oktawian','Kozłowska','2002-04-19','ul. Wkrzańska 94, Szczecin','71-779','Oktawian.Kozłowska@gmail.com','533935801'),
('Bolesław','Przybylska','1972-12-11','ul. Szparagowa 141,Wrocław','52-311','Bolesław.Przybylska@gmail.com','211796765'),
('Jakub','Górecka','1975-11-15','ul. Masztowa 141,Wrocław','51-215','Jakub.Górecka@gmail.com','741423581'),
('Oskar','Urbańska','1998-10-18','ul. Jaworzyńska 93,Legnica','59-204','Oskar.Urbańska@gmail.com','216766775'),
('Lucjan','Michalak','2001-06-16','ul. Świętojerska 2,Warszawa','00-236','Lucjan.Michalak@gmail.com','600963619'),
('Joachim','Kozłowska','1969-03-06','ul. Krasińskiego 72,Olkusz','32-305','Joachim.Kozłowska@gmail.com','423906573'),
('Diego','Mazur','1967-02-06','ul. Sosnkowskiego 47,Opole','45-265','Diego.Mazur@gmail.com','792616092'),
('Emil','Kowalska','1985-02-14','ul. Syta 110,Warszawa','02-993','Emil.Kowalska@gmail.com','883767422'),
('Weronika','Pawlak','1998-08-24','ul. Księdza Zagrodzkiego Adolfa 20,Kraków','30-427','Weronika.Pawlak@gmail.com','137989732'),
('Milena','Kamińska','1968-09-06','ul. Osowska 124,Warszawa','04-302','Milena.Kamińska@gmail.com','378854218'),
('Czesława','Jaworska','1982-12-14','ul. Reja Mikołaja 71,Białystok','15-615','Czesława.Jaworska@gmail.com','274149268'),
('Izabela','Kamińska','1970-01-18','ul. Saperska 137,Brzeg','49-300','Izabela.Kamińska@gmail.com','953237373'),
('Roksana','Piotrowska','2003-01-16','ul. Mickiewicza 68,Toruń','87-104','Roksana.Piotrowska@gmail.com','332511674'),
('Malwina','Zawadzka','1977-03-17','ul. Bonifraterska 112,Warszawa','00-203','Malwina.Zawadzka@gmail.com','240073426'),
('Agata','Kowalska','1971-04-29','ul. Bytomska 124,Piekary Śląskie','41-940','Agata.Kowalska@gmail.com','922755654'),
('Halina','Głowacka','1995-07-15','ul. Starkowska 125,Poznań','61-058','Halina.Głowacka@gmail.com','120999309'),
('Marysia','Kowalska','1997-11-10','ul. Dźwiękowa 85,Łódź','93-414','Marysia.Kowalska@gmail.com','660773735'),
('Olga','Szczepańska','1988-10-07','ul. Głucha 137,Rybnik','44-210','Olga.Szczepańska@gmail.com','132715527'),
('Elżbieta','Sikorska','1992-04-27','ul. Wróblewskiego Walerego 58,Opole','45-759','Elżbieta.Sikorska@gmail.com','479432227'),
('Marlena','Cieślak','1979-12-04','ul. Stara Miłosna ul. Jana Pawła II 15,Warszawa','05-077','Marlena.Cieślak@gmail.com','318343939'),
('Roksana','Dąbrowska','1994-11-17','ul. Weissa 86,Kraków','31-313','Roksana.Dąbrowska@gmail.com','770625637'),
('Alina','Wiśniewska','1977-04-17','ul. Kościuszki 128,Dąbrówka','05-252','Alina.Wiśniewska@gmail.com','687509227'),
('Anastazja','Pietrzak','1979-03-04','ul. Ornitologów 129,Szczecin','71-696','Anastazja.Pietrzak@gmail.com','775717820'),
('Julita','Piotrowska','1981-06-09','ul. Brzozowicka 84,Będzin','42-500','Julita.Piotrowska@gmail.com','117198251'),
('Daria','Kwiatkowska','1997-12-12','ul. Jaworskiego Iwo 1,Wrocław','54-701','Daria.Kwiatkowska@gmail.com','865818241'),
('Patrycja','Szymczak','1998-03-23','ul. Siedlecka 134,Wiśniew','08-112','Patrycja.Szymczak@gmail.com','744015256'),
('Franciszka','Włodarczyk','1981-03-12','ul. Odyńca Antoniego Edwarda 140,Kędzierzyn-koźle','47-206','Franciszka.Włodarczyk@gmail.com','239256227'),
('Lara','Głowacka','1978-05-17','Pl. Waryńskiego Ludwika 108,Chorzów','41-506','Lara.Głowacka@gmail.com','573710422'),
('Alicja','Maciejewska','2000-02-13','ul. Idźkowskiego Adama 64,Warszawa','00-442','Alicja.Maciejewska@gmail.com','663478396'),
('Elwira','Sokołowska','1973-02-22','ul. Dygata Stanisława 44,Wrocław','54-622','Elwira.Sokołowska@gmail.com','434876203'),
('Adela','Sadowska','1998-08-04','ul. Reymonta Władysława Stanisława 117,Będzin','42-500','Adela.Sadowska@gmail.com','394975039')

-- utworzenie kategorii
INSERT INTO Kategorie (Nazwa) VALUES
	('Laptopy'),
	('Myszki'),
	('Monitory'),
	('Klawiatury'),
	('Słuchawki'),
	('Pendrive'),
	('Oprogramowanie'),
	('Pamięci RAM')
-- utworzenie producentów 
INSERT INTO Producent (Nazwa) VALUES
	('ASUS'),
	('ACER'),
	('HP'),
	('DELL'),
	('LENOVO'),
	('MICROSOFT'),
	('LOGITECH'),
	('CORSAIR')
-- utworzenie pracowników
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Katarzyna', 'Adamczyk', 'Starszy doradca klienta', '92031309438')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Henryk', 'Kamiński', 'Doradca klienta', '89042603754')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Barbara', 'Lubomirska', 'Wsparcie Sprzedaży', '87120804841')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Zbigniew', 'Topolski', 'Kierownik sprzedaży', '86070811219')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Judyta', 'Bagno', 'Specjalista sprzedaży', '99010198765')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Ewa', 'Dąbrowska', 'Doradca klienta', '97022217654')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Adam', 'Wszelaki', 'Zastępca kierownika', '89081365470')
INSERT INTO Pracownicy (Imię, Nazwisko, Stanowisko, PESEL) VALUES ('Piotr', 'Niewiadomski', 'Młodszy doradca klienta' , '98112309987')

-- utworzenie statusów
INSERT INTO Statusy (Nazwa) VALUES
('Nowe'),
('Opłacone'),
('Oczekuje na płatność'),
('Realizowane'),
('Czeka na odbiór'),
('Wysłane'),
('Zakończone'),
('Anulowane'),
('Zagubiona przesyłka'),
('W drodze do klienta'),
('Brak rezerwacji'),
('Rezerwacja'),
('Produkt niedostępny'),
('Odrzucone'),
('Rezerwacja wygasa'),
('Dostępny'),
('W koszyku')

-- utworzenie dostawców 
INSERT INTO Dostawa (Dostawca, Rodzaj_dostawy, Cena_dostawy) VALUES 
	('DHL', 'Wysyłka', 15.00),
	('UPS', 'Wysyłka', 14.00),
	('DHL', 'Wysyłka', 15.00),
	('DPD', 'Wysyłka', 15.00),
	('K-EX','Wysyłka', 17.50),
	('Fedex', 'Wysyłka', 20.00),
	('PocztaPolska', 'Wysyłka', 20.00),
	('INPOST', 'Wysyłka', 12.00),
	('Sklep stacjonarny', 'Odbiór osobisty', 0.00)
--- Przypisanie pracownika do producenta
INSERT INTO Opiekun_produktu(PracownicyID, ProducentID) VALUES
	(1,4),
	(2,3),
	(3,5),
	(4,6),
	(5,7),
	(6,8),
	(7,2),
	(8,1)
--- Utworzenie produktów w bazie
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 15,6 ASUS X515JA-BQ1575T i5-1035G1/16GB/512/W10', 'ASUS 15,6" X515JA-BQ1575T i5-1035G1/16GB/512/W10', 1, 1, 32, 2999, 8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 15,6 ASUS D515DA-BQ1127T R3-3250U/8GB/256/Win10', 'ASUS 15,6" D515DA-BQ1127T R3-3250U/8GB/256/Win10', 1,1, 28, 2049, 8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 15,6 ASUS VivoBook 15 K513EA i5-1135G7/16GB/512/Win11', 'ASUS 15,6" VivoBook 15 K513EA i5-1135G7/16GB/512/Win11', 1,1, 13, 3999, 8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 15,6 ASUS X515EA-BQ1007W i3-1115G4/8GB/256/Win11S', 'ASUS 15,6" X515EA-BQ1007W i3-1115G4/8GB/256/Win11S', 1,1, 39, 2249, 8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 15,6 ASUS ROG Strix G15 R7-4800H/16GB/512/W10 RTX3050 144Hz', 'ASUS 15,6" ROG Strix G15 R7-4800H/16GB/512/W10 RTX3050 144Hz', 1,1, 7, 4699, 8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 14,0 ASUS VivoBook S14 M433IA R7-4700U/16GB/512/W10X',	'ASUS 14,0" VivoBook S14 M433IA R7-4700U/16GB/512/W10X', 1,1, 21,3499,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 14,0 ASUS VivoBook S14 M433IA R7-4700U/16GB/512',	'ASUS 14,0" VivoBook S14 M433IA R7-4700U/16GB/512', 1,1,9,2999,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 14,0 ASUS VivoBook 14 X415JA i3-1005G1/8GB/512/W10',	'ASUS 14,0" VivoBook 14 X415JA i3-1005G1/8GB/512/W10', 1,1,19,2199,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 14,0 ASUS ZenBook 14 UM425QA R7-5800H/16GB/1TB/W10',	'ASUS 14,0" ZenBook 14 UM425QA R7-5800H/16GB/1TB/W10', 1,1,15,4999,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('LAPTOP 14,0 ASUS VivoBook S14 M433IA R7-4700U/16GB/960/W10X',	'ASUS 14,0" VivoBook S14 M433IA R7-4700U/16GB/960/W10X', 1,1,8,3799,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 HP 15s Ryzen 7-5700/16GB/512/Win10 IPS Silver','HP 15,6" 15s Ryzen 7-5700/16GB/512/Win10 IPS Silver',3,1,16,3199,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 HP Pavilion 15 Ryzen 5-5500/16GB/512/Win11 Silver','HP 15,6" Pavilion 15 Ryzen 5-5500/16GB/512/Win11 Silver',3,1,11,3099,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 HP Pavilion 15 Ryzen 7-5700/16GB/512/Win11 White','HP 15,6" Pavilion 15 Ryzen 7-5700/16GB/512/Win11 White',3,1,14,3249,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 HP Pavilion 15 Ryzen 5-4500/16GB/512/Win10 Silver','HP 15,6" Pavilion 15 Ryzen 5-4500/16GB/512/Win10 Silver',3,1,29,2849,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 HP 15s i5-1135G7/16GB/512/Win11 Black','HP 15,6" 15s i5-1135G7/16GB/512/Win11 Black',3,1,16,3049,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 13,3 HP Pavilion Aero Ryzen 5-5600/16GB/512/Win10 White','HP 13,3" Pavilion Aero Ryzen 5-5600/16GB/512/Win10 White',3,1,5,3990,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 13,3 HP Spectre 14 x360 i7-1165G7/16GB/1TB/Win10P Blue SV','HP 13,3" Spectre 14 x360 i7-1165G7/16GB/1TB/Win10P Blue SV',3,1,2,6999,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 13,3 HP Pavilion Aero Ryzen 5-5600/8GB/512/Win10 White','HP 13,3" Pavilion Aero Ryzen 5-5600/8GB/512/Win10 White',3,1,7,3699,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 13,3 HP Envy 13 i5-1135G7/16GB/512/Win11 Gold','HP 13,3" Envy 13 i5-1135G7/16GB/512/Win11 Gold',3,1,8,4299,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 13,3 HP Pavilion Aero Ryzen 5-5600/16GB/512/W10 Rose Gold','HP 13,3" Pavilion Aero Ryzen 5-5600/16GB/512/W10 Rose Gold',3,1,10,3800,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 DELL Inspiron 5515 Ryzen 5 5500U/16GB/512/Win11','DELL 15,6" Inspiron 5515 Ryzen 5 5500U/16GB/512/Win11',	4,1,18,3499,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 DELL Inspiron 5505 Ryzen 5 4500U/16GB/256/Win10','DELL 15,6" Inspiron 5505 Ryzen 5 4500U/16GB/256/Win10',	4,1,19,2999,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 DELL Inspiron G15 Ryzen 5 5600H/16GB/512/Win11 RTX3050','DELL 15,6" Inspiron G15 Ryzen 5 5600H/16GB/512/Win11 RTX3050',4,	1,16,4299,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 DELL Inspiron G15 5510 i5-10500H/16GB/512/Win11 GTX1650','DELL 15,6" Inspiron G15 5510 i5-10500H/16GB/512/Win11 GTX1650',4,1,27,3999,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 DELL Inspiron 5505 Ryzen 5 4500U/8GB/256/Win10','DELL 15,6" Inspiron 5505 Ryzen 5 4500U/8GB/256/Win10',4,1,33,2799,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 14,0 DELL Inspiron 5405 Ryzen 7 4700U/16GB/512/Win10P','DELL 14,0" Inspiron 5405 Ryzen 7 4700U/16GB/512/Win10P',4,1,13,4199,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 14,0 DELL Vostro 3400 i3-1115G4/16GB/256/Win11P','DELL 14,0" Vostro 3400 i3-1115G4/16GB/256/Win11P',4,1,12,3399,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 14,0 DELL Inspiron 5402 i3-1115G4/8GB/256','DELL 14,0" Inspiron 5402 i3-1115G4/8GB/256',4,1,9,2499,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 14,0 DELL Vostro 3400 i3-1115G4/8GB/256/Win10P','DELL 14,0" Vostro 3400 i3-1115G4/8GB/256/Win10P',4,1,12,2899,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 14,0 DELL Latitude 5420 i5-1145G7/16GB/512/Win10P','DELL 14,0" Latitude 5420 i5-1145G7/16GB/512/Win10P',4,1,2,5749,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 LENOVO ThinkBook 15 i5-1135G7/16GB/512/Win11P','LENOVO 15,6" ThinkBook 15 i5-1135G7/16GB/512/Win11P',5,1,32,3899,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 LENOVO ThinkBook 14 i3-1115G4/8GB/256/Win10P','LENOVO 15,6" ThinkBook 14 i3-1115G4/8GB/256/Win10P',5,1,29,2199,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 LENOVO IdeaPad 3-15 i5-1035G1/20GB/512/Win10','LENOVO 15,6" IdeaPad 3-15 i5-1035G1/20GB/512/Win10',5,1,11,3049,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 LENOVO Legion 5-15 Ryzen 7/32GB/512 RTX3050Ti 165Hz','LENOVO 15,6" Legion 5-15 Ryzen 7/32GB/512 RTX3050Ti 165Hz',5,1,3,5699,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 LENOVO IdeaPad 3-15 i3-1005G1/8GB/256/Win10','LENOVO 15,6" IdeaPad 3-15 i3-1005G1/8GB/256/Win10',5,1,4,2099,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 17,3 LENOVO Legion 5-17 Ryzen 7/16GB/512/Win10 RTX3060 144Hz','LENOVO 17,3" Legion 5-17 Ryzen 7/16GB/512/Win10 RTX3060 144Hz',5,1,2,6499,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 17,3 LENOVO IdeaPad 3-17 Ryzen 3/12GB/256/Win10','LENOVO 17,3" IdeaPad 3-17 Ryzen 3/12GB/256/Win10',5,1,4,2299,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 17,3 LENOVO Legion 5-17 Ryzen 7/16GB/512/Win11X GTX1650 144Hz','LENOVO 17,3" Legion 5-17 Ryzen 7/16GB/512/Win11X GTX1650 144Hz',5,1,1,5399,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 17,3 LENOVO Legion 5-17 Ryzen 5/16GB/512 GTX1650 144Hz','LENOVO 17,3" Legion 5-17 Ryzen 5/16GB/512 GTX1650 144Hz',5,1,11,4499,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 17,3 LENOVO IdeaPad 3-17 Ryzen 5/20GB/512/Win11X','LENOVO 17,3" IdeaPad 3-17 Ryzen 5/20GB/512/Win11X',5,1,12,3049,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 ACER Aspire 5 i5-1135G7/12GB/512/W10 IPS Srebrny','ACER15,6"Aspire 5 i5-1135G7/12GB/512/W10 IPS Srebrny',2,1,5,3049,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 ACER Aspire 5 i5-1135G7/20GB/512/W10 IPS Srebrny','ACER15,6" Aspire 5 i5-1135G7/20GB/512/W10 IPS Srebrny',2,1,3,3249,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 ACER Aspire 5 i5-1135G7/8GB/512/W10 IPS Srebrny','ACER15,6" Aspire 5 i5-1135G7/8GB/512/W10 IPS Srebrny',2,1,8,2949,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 ACER Aspire 5 i5-1135G7/20GB/960/W10 IPS Srebrny','ACER15,6" Aspire 5 i5-1135G7/20GB/960/W10 IPS Srebrny',2,1,12,3549,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('LAPTOP 15,6 ACER Aspire 3 Athlon 3050U/20GB/64+240/Win11S Srebrny','ACER15,6" Aspire 3 Athlon 3050U/20GB/64+240/Win11S Srebrny',2,1,4,2049,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA 1850 Wireless Mobile Mouse Czarny','MYSZ BEZPRZEWODOWA MICROSOFT 1850 Wireless Mobile Mouse Czarny',6,2,21,59,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA Mobile Mouse Bluetooth (Czarny)','MYSZ BEZPRZEWODOWA MICROSOFT Mobile Mouse Bluetooth (Czarny)',6,2,7,119,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA Bluetooth Mouse Matowa czerń','MYSZ BEZPRZEWODOWA MICROSOFT Bluetooth Mouse Matowa czerń',6,2,6,79,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA Bluetooth Ergonomic Mouse Black','MYSZ BEZPRZEWODOWA MICROSOFT Bluetooth Ergonomic Mouse Black',6,2,3,189,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA Bluetooth Mobile Mouse 3600 Niebieski','MYSZ BEZPRZEWODOWA MICROSOFT Bluetooth Mobile Mouse 3600 Niebieski',6,2,7,115,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES	  					
('MYSZ PRZEWODOWA Ergonomic Mouse USB Black','MYSZ PRZEWODOWA MICROSOFT Ergonomic Mouse USB Black',6,2,12,169,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA Ergonomic Mouse USB Black X','MYSZ PRZEWODOWA MICROSOFT Ergonomic Mouse USB Black X',6,2,6,149,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA Classic Intellimouse','MYSZ PRZEWODOWA MICROSOFT Classic Intellimouse',6,2,5,119,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('MYSZ PRZEWODOWA  MS116 optyczna czarna USB','MYSZ PRZEWODOWA  DELL MS116 optyczna czarna USB',4,2,13,34,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA MS3220 (Czarny)','MYSZ PRZEWODOWA DELL  MS3220 (Czarny)',4,2,42,69,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA MS116 optyczna biała USB','MYSZ PRZEWODOWA DELL MS116 optyczna biała USB',4,2,15,33,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA Alienware 510M','MYSZ PRZEWODOWA DELL Alienware 510M',4,2,8,249,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA MS3220 (Szary)','MYSZ PRZEWODOWA DELL MS3220 (Szary)',4,2,9,69,1)	  	
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA B100 czarna USB','MYSZ PRZEWODOWA LOGITECH B100 czarna USB',7,2,52,39.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA G102 LIGHTSYNC czarna','MYSZ PRZEWODOWA LOGITECH G102 LIGHTSYNC czarna',7,2,13,115,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA M90 Mouse czarna USB','MYSZ PRZEWODOWA LOGITECH M90 Mouse czarna USB',7,2,18,39.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA M100 Szara','MYSZ PRZEWODOWA LOGITECH M100 Szara',7,2,6,49.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ PRZEWODOWA M110 Silent niebieska','MYSZ PRZEWODOWA LOGITECH M110 Silent niebieska',7,2,7,59.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('MYSZ BEZPRZEWODOWA M185 Szara','MYSZ BEZPRZEWODOWA LOGITECH M185 Szara',7,2,7,59.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA M190 Czarna','MYSZ BEZPRZEWODOWA LOGITECH M190 Czarna',7,2,4,65,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA M220 Silent (czarna)','MYSZ BEZPRZEWODOWA LOGITECH M220 Silent (czarna)',7,2,11,89.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA M171 czarna','MYSZ BEZPRZEWODOWA LOGITECH M171 czarna',7,2,8,55,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MYSZ BEZPRZEWODOWA B170 czarna','MYSZ BEZPRZEWODOWA LOGITECH B170 czarna',7,2,16,50,5)	  					
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('KLAWIATURA PRZEWODOWA G213 PRODIGY','KLAWIATURA PRZEWODOWA LOGITECH G213 PRODIGY',7,4,5,229,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('KLAWIATURA PRZEWODOWA K120 Keyboard czarna USB','KLAWIATURA PRZEWODOWA LOGITECH K120 Keyboard czarna USB',7,4,17,65.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('KLAWIATURA PRZEWODOWA Corded Keyboard K280e','KLAWIATURA PRZEWODOWA LOGITECH Corded Keyboard K280e',7,4,13,119,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('KLAWIATURA PRZEWODOWA G413 Silver Tactile','KLAWIATURA PRZEWODOWA LOGITECH G413 Silver Tactile',7,4,3,299.99,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('KLAWIATURA PRZEWODOWA G413 Carbon Tactile','KLAWIATURA PRZEWODOWA LOGITECH G413 Carbon Tactile',7,4,4,299,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 	  					
('KLAWIATURA PRZEWODOWA K55 RGB PRO','KLAWIATURA PRZEWODOWA CORSAIR K55 RGB PRO',8,4,11,239.99,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA PRZEWODOWA K55 RGB PRO XT','KLAWIATURA PRZEWODOWA CORSAIR K55 RGB PRO XT',8,4,6,319,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA PRZEWODOWA K65 RGB MINI 60% (CherryMX Speed)','KLAWIATURA PRZEWODOWA CORSAIR K65 RGB MINI 60% (CherryMX Speed)',8,4,8,499,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA PRZEWODOWA K60 RGB PRO Low Profile','KLAWIATURA PRZEWODOWA CORSAIR K60 RGB PRO Low Profile',8,4,4,599,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA PRZEWODOWA K70 Rapidfire MK.2 (Cherry MX Low Profile Speed)','KLAWIATURA PRZEWODOWA CORSAIR K70 Rapidfire MK.2 (Cherry MX Low Profile Speed)',8,4,8,719,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 	  					
('KLAWIATURA BEZPRZEWODOWA MX Keys','KLAWIATURA BEZPRZEWODOWA LOGITECH MX Keys',7,4,12,449,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA K270 Wireless Keyboard','KLAWIATURA BEZPRZEWODOWA LOGITECH K270 Wireless Keyboard',7,4,23,129,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA K360 Wireless Keyboard','KLAWIATURA BEZPRZEWODOWA LOGITECH K360 Wireless Keyboard',7,4,7,169,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA K375s Multi-Device (Unifying, Bluetooth Smart)','KLAWIATURA BEZPRZEWODOWA LOGITECH K375s Multi-Device (Unifying, Bluetooth Smart)',7,4,8,175,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA K380 for Mac biały','KLAWIATURA BEZPRZEWODOWA LOGITECH K380 for Mac biały',7,4,5,199,5)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES  	  					
('KLAWIATURA BEZPRZEWODOWA All-in-One Media Keyboard','KLAWIATURA BEZPRZEWODOWA MICROSOFT All-in-One Media Keyboard',6,4,10,159,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA Bluetooth Keyboard','KLAWIATURA BEZPRZEWODOWA MICROSOFT Bluetooth Keyboard',6,4,3,209,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA Bluetooth Compact Keyboard Black','KLAWIATURA BEZPRZEWODOWA MICROSOFT Bluetooth Compact Keyboard Black',6,4,7,289,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA Surface Keyboard Bluetooth','KLAWIATURA BEZPRZEWODOWA MICROSOFT Surface Keyboard Bluetooth',6,4,2,399,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 
('KLAWIATURA BEZPRZEWODOWA Bluetooth Compact Keyboard Glacier','KLAWIATURA BEZPRZEWODOWA MICROSOFT Bluetooth Compact Keyboard Glacier',6,4,9,290,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES	  					
('SŁUCHAWKI KOMPUTEROWE HS80 RGB Wireless','SŁUCHAWKI KOMPUTEROWE CORSAIR HS80 RGB Wireless',8,5,5,606,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE HS35 Stereo Gaming Headset (czerwony)','SŁUCHAWKI KOMPUTEROWE CORSAIR HS35 Stereo Gaming Headset (czerwony)',8,5,5,219,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE Void ELITE Surround Cherry','SŁUCHAWKI KOMPUTEROWE CORSAIR Void ELITE Surround Cherry',8,5,5,299,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE HS50 PRO Stereo Blue','SŁUCHAWKI KOMPUTEROWE CORSAIR HS50 PRO Stereo Blue',8,5,5,249,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE HS50 PRO Stereo Carbon','SŁUCHAWKI KOMPUTEROWE CORSAIR HS50 PRO Stereo Carbon',8,5,5,199,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE VOID Elite Stereo Carbon','SŁUCHAWKI KOMPUTEROWE CORSAIR VOID Elite Stereo Carbon',8,5,5,279,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE Void ELITE Wireless Carbon','SŁUCHAWKI KOMPUTEROWE CORSAIR Void ELITE Wireless Carbon',8,5,5,398,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SŁUCHAWKI KOMPUTEROWE Virtuoso RGB Wireless XT','SŁUCHAWKI KOMPUTEROWE CORSAIR Virtuoso RGB Wireless XT',8,5,5,1200,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PENDRIVE  32GB Survivor Stealth (USB 3.0)','PENDRIVE  CORSAIR 32GB Survivor Stealth (USB 3.0)',8,6,10,99,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PENDRIVE  128GB Survivor Stealth (USB 3.0)','PENDRIVE  CORSAIR 128GB Survivor Stealth (USB 3.0)',8,6,10,189,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PENDRIVE  128GB Voyager GT (USB 3.0) 390MB/s','PENDRIVE  CORSAIR 128GB Voyager GT (USB 3.0) 390MB/s',8,6,15,189,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PENDRIVE  16GB Padlock 3 Secure (USB 3.0)','PENDRIVE  CORSAIR 16GB Padlock 3 Secure (USB 3.0)',8,6,11,229,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PENDRIVE  32GB Voyager GT (USB 3.0) 390MB/s','PENDRIVE  CORSAIR 32GB Voyager GT (USB 3.0) 390MB/s',8,6,14,98,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES						
('SYSTEM OPERACYJNY Microsoft Windows 10 PRO PL 64bit OEM DVD','Microsoft Windows 10 PRO PL 64bit OEM DVD',6,7,10,649,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SYSTEM OPERACYJNY Microsoft Windows 10 PRO PL 32/64bit BOX USB','Microsoft Windows 10 PRO PL 32/64bit BOX USB',6,7,10,969,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SYSTEM OPERACYJNY Microsoft Windows 10 Home PL 32/64bit BOX USB','Microsoft Windows 10 Home PL 32/64bit BOX USB',6,7,10,559,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SYSTEM OPERACYJNY Microsoft Windows 10 Home PL 64bit OEM DVD','Microsoft Windows 10 Home PL 64bit OEM DVD',6,7,10,489,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SYSTEM OPERACYJNY Microsoft Windows 11 PRO PL 64bit OEM DVD','Microsoft Windows 11 PRO PL 64bit OEM DVD',6,7,10,649,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('SYSTEM OPERACYJNY Microsoft Windows 11 Home PL 64bit OEM DVD','Microsoft Windows 11 Home PL 64bit OEM DVD',6,7,10,489,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PROGRAM BIUROWY Microsoft Office Home & Business 2021','Microsoft Office Home & Business 2021',6,7,15,1199,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PROGRAM BIUROWY Microsoft Office Home & Student 2021','Microsoft Office Home & Student 2021',6,7,15,599,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PROGRAM BIUROWY Microsoft 365 Personal ESD','Microsoft 365 Personal ESD',6,7,15,299,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PROGRAM BIUROWY Microsoft 365 Business Standard','Microsoft 365 Business Standard',6,7,15,599,4)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR DELL P2422H, 1920 x 1080 (FullHD), 60 Hz, HDMI','MONITOR DELL P2422H, 1920 x 1080 (FullHD), 60 Hz, HDMI',4,3,13,1039,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR DELL Alienware AW2521HFA czarny 240Hz, 1920 x 1080, HDMI','MONITOR DELL Alienware AW2521HFA czarny 240Hz, 1920 x 1080, HDMI',4,3,15,1699,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR DELL S2421HGF czarny, 1920 x 1080, HDMI, 144Hz','MONITOR DELL S2421HGF czarny, 1920 x 1080, HDMI, 144Hz',4,3,24,929,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR DELL P2421, 1920 x 1200, 60Hz, HDMI','MONITOR DELL P2421, 1920 x 1200, 60Hz, HDMI',4,3,35,899,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR DELL SE2417HGX,1920 x 1080, 60 Hz, HDMI','MONITOR DELL SE2417HGX,1920 x 1080, 60 Hz, HDMI',4,3,18,609,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES 					
('MONITOR ACER KG241BMIIX czarny, 1920 x 1080, TN, Płaski','MONITOR ACER KG241BMIIX czarny, 1920 x 1080, TN, Płaski',2,3,12,569,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ACER Nitro VG240YBMIIX czarny, 1920x1080, LED, IPS','MONITOR ACER Nitro VG240YBMIIX czarny, 1920x1080, LED, IPS',2,3,9,699,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ACER SB241Y, 1920x1080, LED,IPS, 75Hz','MONITOR ACER SB241Y, 1920x1080, LED,IPS, 75Hz',2,3,16,649,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ACER Acer CB242YBMIPRX czarny, 1920x1080, LED, IPS','MONITOR ACER Acer CB242YBMIPRX czarny, 1920x1080, LED, IPS',2,3,22,799,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ACER EG240YPBIPX czarny','MONITOR ACER EG240YPBIPX czarny',2,3,12,849,7)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES				
('MONITOR ASUS TUF VG249Q, 1920x1080, LED, IPS','MONITOR ASUS TUF VG249Q, 1920x1080, LED, IPS',1,3,11,899,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ASUS VA24EHE, 1920x1080, LED, IPS','MONITOR ASUS VA24EHE, 1920x1080, LED, IPS',1,3,8,849,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ASUS VZ229HE Ultra-Slim, 1920x1080, LED, IPS','MONITOR ASUS VZ229HE Ultra-Slim, 1920x1080, LED, IPS',1,3,21,579,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ASUS ROG SWIFT PG259QN HDR, 1920x1080, LED, IPS','MONITOR ASUS ROG SWIFT PG259QN HDR, 1920x1080, LED, IPS',1,3,4,3299,8)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR ASUS TUF VG27WQ Curved HDR,2560 x 1440, HDMI','MONITOR ASUS TUF VG27WQ Curved HDR,2560 x 1440, HDMI',1,3,12,1569,8)					
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR HP X24c Curved, 1920 x 1080, LED','MONITOR HP X24c Curved, 1920 x 1080, LED',3,3,11,769,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR HP X27qc, 2560 x 1440, LED,VA','MONITOR HP X27qc, 2560 x 1440, LED,VA',3,3,8,1299,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR HP OMEN 27i Gaming, 2560 x 1440, LED,IPS','MONITOR HP OMEN 27i Gaming, 2560 x 1440, LED,IPS',3,3,12,1899,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR HP OMEN 25, 1920x1080, LED,TN','MONITOR HP OMEN 25, 1920x1080, LED,TN',3,3,15,899,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR HP OMEN X 25f Gaming, 1920x1080','MONITOR HP OMEN X 25f Gaming, 1920x1080',3,3,27,1469,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES	 					
('MONITOR LENOVO G24-10 czarny Gaming','MONITOR LENOVO G24-10 czarny Gaming',5,3,12,799,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR LENOVO ThinkVision T24i-2L czarny','MONITOR LENOVO ThinkVision T24i-2L czarny',5,3,9,969,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR LENOVO L24e-30 czarny','MONITOR LENOVO L24e-30 czarny',5,3,21,659,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR LENOVO G27-20 czarny','MONITOR LENOVO G27-20 czarny',5,3,12,1099,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('MONITOR LENOVO G27c-10 czarny 165Hz','MONITOR LENOVO G27c-10 czarny 165Hz',5,3,14,1199,3)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES					
('PAMIĘĆ RAM 16GB (2x8GB) 3600MHz CL18 Vengeance RGB PRO SL','PAMIĘĆ RAM CORSAIR 16GB (2x8GB) 3600MHz CL18 Vengeance RGB PRO SL',8,8,10,419,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 16GB (2x8GB) 3200MHz CL16 Vengeance LPX Red','PAMIĘĆ RAM CORSAIR 16GB (2x8GB) 3200MHz CL16 Vengeance LPX Red',8,8,11,389,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 8GB (1x8GB) 2400MHz CL14 Vengeance LPX Red','PAMIĘĆ RAM CORSAIR 8GB (1x8GB) 2400MHz CL14 Vengeance LPX Red',8,8,27,187,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 8GB (1x8GB) 2666MHz CL16 Vengeance LPX Red','PAMIĘĆ RAM CORSAIR 8GB (1x8GB) 2666MHz CL16 Vengeance LPX Red',8,8,12,155,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 8GB (1x8GB) 3000MHz CL16 Vengeance LPX Black','PAMIĘĆ RAM CORSAIR 8GB (1x8GB) 3000MHz CL16 Vengeance LPX Black',8,8,19,179,6)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM Memory Upgrade - 16GB - 2Rx8 DDR4 RDIMM 3200MHz','PAMIĘĆ RAM DELL Memory Upgrade - 16GB - 2Rx8 DDR4 RDIMM 3200MHz',4,8,8,1599,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM Memory Upgrade 16GB - 2RX8 DDR4 UDIMM 2666Mhz ECC','PAMIĘĆ RAM DELL Memory Upgrade 16GB - 2RX8 DDR4 UDIMM 2666Mhz ECC',4,8,8,999,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM Memory Upgrade 8GB - 1RX8 DDR4 UDIMM 2666MHz ECC','PAMIĘĆ RAM DELL Memory Upgrade 8GB - 1RX8 DDR4 UDIMM 2666MHz ECC',4,8,11,540,1)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES	  					
('PAMIĘĆ RAM 8GB (1x8GB) 3600MHz CL18 V6','PAMIĘĆ RAM HP 8GB (1x8GB) 3600MHz CL18 V6',3,8,12,299,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 8GB (1x8GB) 3200MHz CL16 V6','PAMIĘĆ RAM HP 8GB (1x8GB) 3200MHz CL16 V6',3,8,15,269,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 4GB (1x4GB) 2666 MHz CL19 V2','PAMIĘĆ RAM HP 4GB (1x4GB) 2666 MHz CL19 V2',3,8,17,119,2)
INSERT INTO Produkty (Nazwa, Opis, ProducentID, KategoriaID, Ilość, Cena, OpiekunProduktuID) VALUES
('PAMIĘĆ RAM 8GB (1x8GB) 2666MHz CL19 V2','PAMIĘĆ RAM HP 8GB (1x8GB) 2666MHz CL19 V2',3,8,19,219,2)

--- Utworzenie koszyków (zamówień) z wybranymi przez klientów produktami
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('42','2021-03-04','0','7','9','2021-03-06','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('16','2021-03-31','0','7','5','2021-04-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('72','1','299.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-03-15','0','7','2','2021-03-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('99','1','189.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('70','1','65.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-03-14','0','7','9','2021-03-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('86','1','289.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-03-23','0','7','6','2021-03-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('93','1','199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('15','2021-03-10','0','7','1','2021-03-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('60','1','115.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('39','2021-03-17','0','7','6','2021-03-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('88','1','290.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('6','2021-03-19','0','7','6','2021-03-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('129','1','1899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('4','2021-03-04','0','7','9','2021-03-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('111','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('33','2021-03-09','0','7','7','2021-03-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('25','2021-03-01','0','7','9','2021-03-04','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('53','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('99','1','189.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('50','1','115.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('82','1','175.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-03-01','0','7','4','2021-03-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('51','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('10','2021-03-12','0','7','1','2021-03-13','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('9','1','4999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('30','1','5749.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-04-09','0','7','9','2021-04-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-04-10','0','7','2','2021-04-13','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-04-30','0','7','7','2021-05-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('106','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-04-30','0','7','1','2021-05-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('96','1','1200.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('144','1','540.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('15','2021-04-11','0','7','4','2021-04-13','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('116','1','609.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-04-28','0','7','8','2021-05-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('56','1','33.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('13','1','3249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('2','2021-04-30','0','7','2','2021-05-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('15','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('13','2021-04-02','0','7','3','2021-04-04','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('60','1','115.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('42','2021-04-14','0','7','6','2021-04-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('38','1','5399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('53','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('11','1','3199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-04-16','0','7','4','2021-04-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('130','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('28','2021-04-09','0','7','5','2021-04-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('30','1','5749.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('25','2021-04-17','0','7','1','2021-04-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('49','1','189.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('1','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('46','2021-04-04','0','7','9','2021-04-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('121','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('68','1','50.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-04-13','0','7','7','2021-04-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('121','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('27','2021-04-10','0','7','3','2021-04-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('124','1','579.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('26','2021-04-12','0','7','9','2021-04-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('80','1','129.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('124','1','579.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-04-25','0','7','1','2021-04-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('35','1','2099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('14','2021-05-31','0','7','9','2021-06-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('85','1','209.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-05-21','0','7','6','2021-05-23','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('2','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('8','2021-05-07','0','7','4','2021-05-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('25','1','2799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-05-31','0','7','7','2021-06-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('19','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-05-14','0','7','6','2021-05-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('45','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('10','2021-05-19','0','7','7','2021-05-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('22','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('29','2021-05-01','0','7','7','2021-05-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('28','1','2499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-05-24','0','7','8','2021-05-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('63','1','59.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('145','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('43','2021-05-15','0','7','4','2021-05-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('4','2021-05-10','0','7','1','2021-05-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('1','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-05-02','0','7','1','2021-05-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('143','1','999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('43','2021-05-12','0','7','7','2021-05-13','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-05-15','0','7','9','2021-05-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('29','1','2899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-05-27','0','7','1','2021-05-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('39','1','4499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-05-31','0','7','5','2021-06-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('108','1','1199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-05-11','0','7','5','2021-05-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-05-21','0','7','5','2021-05-23','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('64','1','59.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('55','1','69.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-05-13','0','7','3','2021-05-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('80','1','129.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('40','2021-05-19','0','7','5','2021-05-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('28','1','2499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('45','2021-05-07','0','7','3','2021-05-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('145','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('15','2021-05-26','0','7','9','2021-05-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-06-05','0','7','3','2021-06-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('119','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-06-12','0','7','4','2021-06-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('7','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-06-04','0','7','9','2021-06-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('97','1','99.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('145','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('33','2021-06-07','0','7','6','2021-06-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('113','1','1699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('16','2021-06-10','0','7','4','2021-06-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('126','1','1569.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('47','2021-06-30','0','7','6','2021-07-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('111','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-06-07','0','7','6','2021-06-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('100','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('32','1','2199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('41','2021-06-16','0','7','2','2021-06-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('118','1','699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-06-21','0','7','5','2021-06-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('143','1','999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('39','2021-06-26','0','7','8','2021-06-29','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('34','2021-06-04','0','7','3','2021-06-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('103','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('28','2021-06-22','0','7','7','2021-06-25','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('48','2021-06-20','0','7','5','2021-06-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('88','1','290.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('104','1','559.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-06-28','0','7','7','2021-06-29','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('134','1','659.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-06-17','0','7','5','2021-06-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('6','1','3499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('15','2021-06-03','0','7','4','2021-06-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('38','1','5399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-06-23','0','7','5','2021-06-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('148','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('17','2021-07-27','0','7','6','2021-07-29','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('109','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-07-05','0','7','4','2021-07-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('76','1','499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('47','2021-07-20','0','7','8','2021-07-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('53','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-07-31','0','7','1','2021-08-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('110','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('28','2021-07-13','0','7','4','2021-07-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('35','1','2099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('13','2021-07-03','0','7','3','2021-07-06','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('62','1','49.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('56','1','33.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('10','2021-07-18','0','7','7','2021-07-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-07-06','0','7','1','2021-07-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('18','1','3699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-07-15','0','7','3','2021-07-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('54','1','34.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('71','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('10','2021-07-10','0','7','1','2021-07-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('136','1','1199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-07-28','0','7','5','2021-07-30','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('13','1','3249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-07-30','0','7','2','2021-08-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('119','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('101','1','98.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-07-22','0','7','7','2021-07-25','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('116','1','609.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-07-06','0','7','4','2021-07-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('48','2021-07-11','0','7','8','2021-07-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('33','2021-07-04','0','7','1','2021-07-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-07-01','0','7','4','2021-07-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('33','2021-07-04','0','7','3','2021-07-06','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-07-14','0','7','9','2021-07-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('59','1','39.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('41','2021-07-02','0','7','7','2021-07-04','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('39','1','4499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-08-10','0','7','1','2021-08-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('140','1','155.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-08-22','0','7','9','2021-08-25','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('6','2021-08-01','0','7','7','2021-08-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('111','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('1','2021-08-30','0','7','4','2021-08-31','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('44','1','3549.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-08-19','0','7','5','2021-08-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('32','1','2199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('2','2021-08-29','0','7','9','2021-08-31','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('13','2021-08-17','0','7','5','2021-08-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('32','1','2199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('4','2021-08-17','0','7','4','2021-08-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('121','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('31','2021-08-02','0','7','7','2021-08-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-08-13','0','7','3','2021-08-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('66','1','89.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('17','2021-08-09','0','7','8','2021-08-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('50','2021-08-15','0','7','6','2021-08-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-08-15','0','7','7','2021-08-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('95','1','398.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('85','1','209.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-08-15','0','7','9','2021-08-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('73','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-08-10','0','7','5','2021-08-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('123','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-08-16','0','7','8','2021-08-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('48','2021-08-25','0','7','5','2021-08-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('39','2021-08-01','0','7','3','2021-08-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('47','2021-08-24','0','7','8','2021-08-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('21','1','3499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('45','2021-08-15','0','7','8','2021-08-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('57','1','249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-08-20','0','7','9','2021-08-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('3','1','3999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-08-05','0','7','6','2021-08-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('100','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('24','1','3999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-08-11','0','7','1','2021-08-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('49','1','189.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('49','2021-09-15','0','7','8','2021-09-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('79','1','449.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('76','1','499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('41','2021-09-08','0','7','1','2021-09-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('38','1','5399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-09-17','0','7','9','2021-09-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('40','2021-09-09','0','7','5','2021-09-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('38','1','5399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('50','2021-09-26','0','7','8','2021-09-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('2','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-09-09','0','7','3','2021-09-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('2','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-09-28','0','7','9','2021-09-29','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('7','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('37','1','2299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('2','2021-09-12','0','7','7','2021-09-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('41','2021-09-07','0','7','8','2021-09-09','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('59','1','39.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('128','1','1299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('42','2021-09-24','0','7','7','2021-09-25','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('88','1','290.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('25','2021-09-17','0','7','6','2021-09-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('47','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-09-20','0','7','7','2021-09-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('68','1','50.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('55','1','69.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('44','2021-09-16','0','7','6','2021-09-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('14','2021-09-07','0','7','6','2021-09-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('48','2021-09-25','0','7','4','2021-09-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('7','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('131','1','1469.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('3','2021-09-04','0','7','2','2021-09-06','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('97','1','99.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-10-30','0','7','4','2021-11-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('108','1','1199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('8','2021-10-15','0','7','1','2021-10-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('120','1','799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('52','1','149.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-10-31','0','7','5','2021-11-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('86','1','289.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-10-02','0','7','9','2021-10-04','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-10-30','0','7','3','2021-11-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('16','1','3990.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-10-08','0','7','1','2021-10-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('118','1','699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('126','1','1569.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('49','2021-10-20','0','7','1','2021-10-23','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('19','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-10-14','0','7','1','2021-10-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-10-18','0','7','9','2021-10-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('17','2021-10-16','0','7','6','2021-10-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('13','1','3249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('6','2021-10-27','0','7','5','2021-10-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('40','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('36','1','6499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-10-28','0','7','2','2021-10-30','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('29','2021-10-12','0','7','3','2021-10-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('78','1','719.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('119','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('35','2021-10-21','0','7','3','2021-10-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('24','1','3999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('28','2021-10-31','0','7','8','2021-11-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('31','1','3899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-10-23','0','7','4','2021-10-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('42','1','3249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('35','2021-10-20','0','7','8','2021-10-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('91','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-10-13','0','7','1','2021-10-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('83','1','199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('21','1','3499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-11-19','0','7','6','2021-11-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('21','1','3499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('91','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('80','1','129.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-11-14','0','7','7','2021-11-16','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('73','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-11-24','0','7','8','2021-11-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('11','1','3199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('42','2021-11-04','0','7','4','2021-11-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-11-24','0','7','1','2021-11-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('9','1','4999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('18','1','3699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-11-19','0','7','8','2021-11-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('20','1','3800.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-11-13','0','7','2','2021-11-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('20','1','3800.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('45','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('71','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-11-11','0','7','9','2021-11-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('25','1','2799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('32','1','2199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('125','1','3299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('4','1','2249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-11-27','0','7','5','2021-11-30','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('14','1','2849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('1','2021-11-03','0','7','1','2021-11-04','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('45','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('11','1','3199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('39','2021-11-18','0','7','9','2021-11-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('64','1','59.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('62','1','49.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('73','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('123','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-11-15','0','7','4','2021-11-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('88','1','290.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-11-30','0','7','7','2021-12-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('6','1','3499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('31','2021-11-10','0','7','3','2021-11-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-11-19','0','7','7','2021-11-20','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('48','1','79.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('81','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('49','2021-11-03','0','7','6','2021-11-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-11-23','0','7','4','2021-11-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('67','1','55.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('78','1','719.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('45','2021-11-25','0','7','9','2021-11-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('105','1','489.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-11-07','0','7','4','2021-11-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('87','1','399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('111','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('49','1','189.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('46','2021-11-11','0','7','8','2021-11-13','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('20','1','3800.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-11-21','0','7','4','2021-11-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('119','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('122','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('66','1','89.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('49','2021-11-29','0','7','9','2021-12-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('110','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('22','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('34','1','5699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('7','2021-12-08','0','7','5','2021-12-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('2','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('2','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('4','1','2249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('19','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-12-03','0','7','1','2021-12-06','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('8','1','2199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('108','1','1199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-12-25','0','7','2','2021-12-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('130','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('44','2021-12-04','0','7','3','2021-12-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('130','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('140','1','155.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('85','1','209.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('145','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('123','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('108','1','1199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('52','1','149.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('4','2021-12-16','0','7','6','2021-12-18','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('94','1','279.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('39','1','4499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('31','2021-12-22','0','7','4','2021-12-23','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('82','1','175.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('120','1','799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('109','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('40','2021-12-25','0','7','1','2021-12-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('109','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('17','1','6999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('97','1','99.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('86','1','289.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-12-06','0','7','9','2021-12-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('57','1','249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('142','1','1599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('14','2021-12-13','0','7','6','2021-12-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('142','1','1599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('35','1','2099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('11','1','3199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('17','2021-12-12','0','7','1','2021-12-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('52','1','149.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('44','1','3549.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-12-31','0','7','8','2022-01-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('26','2021-12-31','0','7','4','2022-01-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('130','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('124','1','579.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('17','2021-12-01','0','7','5','2021-12-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('33','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('14','1','2849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-12-16','0','7','4','2021-12-17','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('56','1','33.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('143','1','999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('3','1','3999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('23','2021-12-27','0','7','8','2021-12-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('106','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('10','1','3799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('48','1','79.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('56','1','33.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('134','1','659.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-12-29','0','7','4','2022-01-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('86','1','289.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('124','1','579.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('44','2021-12-06','0','7','5','2021-12-08','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('74','1','239.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('47','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('29','2021-12-28','0','7','2','2021-12-31','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('19','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-12-08','0','7','1','2021-12-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('30','1','5749.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('42','2021-12-24','0','7','9','2021-12-25','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('52','1','149.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('132','1','799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('61','1','39.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('44','2021-12-25','0','7','5','2021-12-28','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('134','1','659.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('147','1','119.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('109','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-12-07','0','7','5','2021-12-09','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('45','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('24','1','3999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('40','2021-12-09','0','7','5','2021-12-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('144','1','540.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('129','1','1899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('34','2021-12-08','0','7','5','2021-12-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('27','1','3399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('91','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('76','1','499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-01-19','0','7','8','2021-01-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('111','1','599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('45','1','2049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('4','1','2249.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('5','2021-01-08','0','7','5','2021-01-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('67','1','55.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('65','1','65.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('37','1','2299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('13','2021-01-18','0','7','2','2021-01-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-01-17','0','7','2','2021-01-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('35','2021-01-19','0','7','1','2021-01-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('51','1','169.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('122','1','899.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('101','1','98.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-01-21','0','7','2','2021-01-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('142','1','1599.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('40','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('106','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('8','2021-01-28','0','7','4','2021-01-31','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('25','1','2799.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-01-16','0','7','6','2021-01-19','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('121','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('8','2021-01-18','0','7','5','2021-01-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('125','1','3299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-01-31','0','7','7','2021-02-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('90','1','219.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('36','1','6499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('4','2021-01-25','0','7','9','2021-01-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('36','1','6499.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('39','2021-01-09','0','7','5','2021-01-10','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('134','1','659.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-01-08','0','7','1','2021-01-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('125','1','3299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('69','1','229.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('15','2021-01-28','0','7','2','2021-01-30','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('138','1','389.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('6','2021-01-22','0','7','4','2021-01-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('87','1','399.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('75','1','319.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('62','1','49.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('44','1','3549.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('22','2021-02-26','0','7','4','2021-03-01','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('75','1','319.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('62','1','49.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('68','1','50.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('21','2021-02-03','0','7','6','2021-02-05','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('43','1','2949.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('43','2021-02-23','0','7','3','2021-02-26','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('82','1','175.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-02-25','0','7','2','2021-02-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('101','1','98.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('12','2021-02-05','0','7','4','2021-02-07','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('119','1','649.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('30','2021-02-10','0','7','9','2021-02-11','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('7','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('31','2021-02-24','0','7','4','2021-02-27','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-02-11','0','7','8','2021-02-14','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('23','1','4299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('9','2021-02-19','0','7','3','2021-02-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('82','1','175.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('8','2021-02-18','0','7','6','2021-02-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('127','1','769.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('91','1','299.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('27','2021-02-22','0','7','6','2021-02-23','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('146','1','269.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-02-28','0','7','8','2021-03-03','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('41','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('123','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-02-23','0','7','1','2021-02-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('135','1','1099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('31','2021-02-21','0','7','5','2021-02-24','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('118','1','699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('20','2021-02-20','0','7','6','2021-02-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('14','1','2849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('118','1','699.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('19','2021-02-10','0','7','4','2021-02-12','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-02-08','0','7','1','2021-02-09','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('141','1','179.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('62','1','49.99','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('11','2021-03-30','0','7','5','2021-04-02','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('7','1','2999.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('137','1','419.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('32','2021-03-19','0','7','8','2021-03-22','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('82','1','175.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('80','1','129.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('36','2021-03-19','0','7','2','2021-03-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('48','1','79.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('33','1','3049.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('121','1','849.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('18','2021-03-29','0','7','9','2021-03-30','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('37','2021-03-12','0','7','4','2021-03-15','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('26','1','4199.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('52','1','149.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('12','1','3099.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Koszyk (KlientID, Data_zamówienia, Kwota_razem, StatusID, DostawaID, Data_dostawy, Status_płatnościID) VALUES ('24','2021-03-18','0','7','3','2021-03-21','2')
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('78','1','719.00','16',IDENT_CURRENT('Koszyk'))
INSERT INTO Wybrane_produkty (produktID, Ilość, Suma, StatusID, koszykID) VALUES ('133','1','969.00','16',IDENT_CURRENT('Koszyk'))

--- Dodanie Rezerwacje produktów
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('37','41','13','2021-11-15')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('47','143','14','2021-07-05')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('34','94','13','2021-09-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('45','55','14','2021-08-07')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('36','25','13','2021-12-13')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('15','73','14','2021-08-19')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('45','112','13','2021-08-11')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('24','61','15','2021-09-01')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('21','29','15','2021-03-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('32','107','14','2021-11-02')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('8','7','13','2021-04-16')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('8','143','13','2021-10-15')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('46','84','14','2021-07-25')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('8','13','15','2021-05-06')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('9','114','14','2021-05-03')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('3','30','15','2021-03-07')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('23','139','13','2021-06-12')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('39','28','15','2021-11-24')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('21','22','13','2021-10-02')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('47','69','15','2021-03-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('41','103','15','2021-10-12')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('49','138','15','2021-06-16')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('17','56','15','2021-08-19')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('41','82','15','2021-04-29')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('42','29','14','2021-04-05')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('3','126','14','2021-02-12')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('27','21','14','2021-09-12')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('33','69','13','2021-10-02')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('31','104','7','2021-04-01')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('25','29','8','2021-10-22')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('9','75','8','2021-08-20')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('37','7','8','2021-10-10')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('45','77','8','2021-06-18')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('44','82','7','2021-08-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('40','58','7','2021-04-20')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('40','139','7','2021-06-21')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('17','134','7','2021-11-19')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('16','76','8','2021-05-23')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('28','75','7','2021-09-27')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('15','117','7','2021-01-31')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('6','71','8','2021-10-16')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('18','34','8','2021-11-15')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('48','118','7','2021-03-28')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('10','36','7','2021-10-24')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('34','88','7','2021-09-01')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('12','12','7','2021-09-10')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('30','139','7','2021-05-13')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('14','45','8','2021-04-17')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('24','31','8','2021-11-23')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('9','25','7','2021-12-11')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('36','104','8','2021-03-07')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('32','79','7','2021-02-15')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('3','82','7','2021-01-21')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('13','95','8','2021-09-16')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('37','41','13','2022-11-15')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('47','143','14','2022-07-05')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('34','94','13','2022-09-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('45','55','14','2022-08-07')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('36','25','13','2022-12-13')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('15','73','14','2022-08-19')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('45','112','13','2022-08-11')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('24','61','15','2022-09-01')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('21','29','15','2022-03-04')
INSERT INTO Rezerwacje_produktów (KlientID, ProduktID, StatusID, Data_konca_rezerwacji) VALUES ('32','107','14','2022-11-02')

-- przypisanie rabatów klientom 
INSERT INTO Rabaty (KlientID, Procent) VALUES ('1','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('2','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('3','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('4','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('5','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('6','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('7','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('8','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('9','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('10','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('11','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('12','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('13','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('14','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('15','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('16','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('17','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('18','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('19','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('20','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('21','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('22','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('23','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('24','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('25','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('26','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('27','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('28','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('29','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('30','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('31','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('32','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('33','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('34','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('35','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('36','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('37','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('38','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('39','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('40','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('41','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('42','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('43','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('44','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('45','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('46','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('47','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('48','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('49','5')
INSERT INTO Rabaty (KlientID, Procent) VALUES ('50','5')


-- sprawdzenie --
select * from Statusy;
select * from Koszyk;
select * from Wybrane_produkty;
select * from Produkty;
select * from Opiekun_produktu;
select * from Pracownicy;
select * from Kategorie;
select * from Dostawa;
select * from Producent;
select * from Klienci;

-- tworzenie widoku 1

CREATE VIEW [dbo].[v_SzczegolyProduktow]
AS
SELECT Produkty.Nazwa AS Nazwa_Produktu,
		Producent.Nazwa AS Producent, Kategorie.Nazwa AS Kategoria,
		Produkty.Cena AS Cena, Produkty.Ilość AS Ilość_Sztuk
FROM	
	Produkty 
	LEFT JOIN Producent ON Produkty.ProducentID = Producent.ID_producent
	LEFT JOIN Kategorie ON Produkty.KategoriaID = Kategorie.ID_kategorie

-- tworzenie widoku 2
	
CREATE VIEW [dbo].[v_ZakupyKlientówPowyżejKwoty1000]
AS
SELECT Klienci.Imię + ' ' + Klienci.Nazwisko AS Imię_Nazwisko, Koszyk.Kwota_razem AS ZAPŁACONO
FROM Koszyk
	LEFT JOIN Klienci ON Koszyk.KlientID = Klienci.ID_klienci
	WHERE Koszyk.Kwota_razem > 1000 AND Koszyk.Status_płatnościID=2;

-- tworzenie funkcji 1

create function JakiRabat 
(@klient_ID int)
returns int
AS
BEGIN
		DECLARE @suma int
		SELECT @suma = CASE 
        WHEN sum(Kwota_razem) > 18000 THEN 15 
		WHEN sum(Kwota_razem) > 14000 THEN 10
		WHEN sum(Kwota_razem) > 10000 THEN 5
		END
		FROM Koszyk where KlientID=@klient_ID;
		RETURN @suma
END

-- tworzenie funkcji 2

CREATE FUNCTION weryfikacja
	()
RETURNS TABLE 
AS
RETURN
		select wp.ID_zamowienia,p.Nazwa,p.Cena,wp.Ilość,wp.Suma,p.Cena*wp.Ilość as powinnobyc from Wybrane_produkty as wp
		JOIN Produkty AS p ON wp.produktID=p.ID_produkty where wp.suma<>(p.Cena*wp.Ilość)
GO

-- tworzenie funkcji 3

CREATE FUNCTION dbo.OpiekunowieProduktu
(@NazwaProduktu nvarchar (250))
RETURNS TABLE 
AS 
RETURN
	SELECT pro.Nazwa AS Producent,p.Nazwa AS Produkt, Pra.Imię,Pra.Nazwisko FROM Produkty AS p 
	JOIN Opiekun_produktu AS op ON (p.OpiekunProduktuID=op.ID_opiekun)
	JOIN Pracownicy AS pra ON (pra.ID_pracownicy=op.PracownicyID)
	JOIN Producent AS pro ON (pro.ID_producent=op.ProducentID)
	WHERE
		p.Nazwa LIKE '%'+ @NazwaProduktu + '%'
GO

-- tworzenie procedury 1

GO
CREATE PROCEDURE [dbo].DodajKlienta
	@Imię nvarchar (250),
	@Nazwisko nvarchar (250),
	@Data_urodzenia datetime,
	@Adres_zam nvarchar (250),
	@Kod_pocztowy nvarchar (250),
	@Email nvarchar (250),
	@Tel_kom nvarchar (20)
AS
BEGIN
	INSERT INTO Klienci
	VALUES (@Imię, @Nazwisko, @Data_urodzenia, @Adres_zam, @Kod_pocztowy, @Email, @Tel_kom)
END

-- tworzenie procedury 2


GO
CREATE PROCEDURE [dbo].DodajProdukt
		@Nazwa nvarchar (250),
		@Opis nvarchar (250),
		@ProducentID int,
		@KategoriaID int,
		@Ilość int,
		@Cena decimal (8,2),
		@OpiekunProduktuID int
AS
BEGIN
	INSERT Produkty 
	VALUES (@Nazwa, @Opis, @ProducentID, @KategoriaID, @Ilość, @Cena, @OpiekunProduktuID)
END

-- tworzenie procedury 3

CREATE PROCEDURE SumaKoszyka
	@ID_koszyka int
AS
BEGIN
	UPDATE Koszyk SET Kwota_razem = (SELECT SUM(Suma) FROM Wybrane_produkty where koszykID=@ID_koszyka AND (StatusID in (16,17))) where ID_koszyka = @ID_koszyka AND Status_płatnościID=2;
END

-- tworzenie procedury 4

CREATE PROCEDURE [dbo].CzyszczenieRezerwacjiPoTerminie
AS
BEGIN
	delete FROM Rezerwacje_produktów where Data_konca_rezerwacji < GETDATE();
END

-- tworzenie procedury 5

CREATE PROCEDURE [dbo].PrzypiszRabatDzieńKobiet
@Rabat int
AS
BEGIN
	DELETE FROM Rabaty where KlientID in (select ID_klienci from Klienci where Imię Like '%a') -- to wywala rabaty kobiet
	INSERT INTO Rabaty (KlientID, Procent)
	SELECT ID_klienci, @Rabat from Klienci where Imię Like '%a'
END
