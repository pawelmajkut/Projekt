# Temat projektu: Aplikacja do zarządzania sklepem internetowym

## Wizualnie
### Okno ze stackpanelem - funkcje aplikacji:
-	Zakładka z danymi klientów
-	Zakładka z koszykami klientów 
-	Zakładka z danymi pracowników sklepu
-	Zakładka z dostępnymi produktami
-	Lista z rezerwacjami produktów

#### Zakładka z danymi klientów:
- Tabela z danymi klientów
- Wyszukiwanie klientów według: imienia, nazwiska, płci, miasta, roku urodzenia
- Przyciski do dodawania, usuwania, edycji klienta

#### Zakładka z koszykami klientów:
- W przygotowaniu…

#### Zakładka z danymi pracowników:
- Tabela z danymi pracowników
- Wyszukiwanie pracowników według: imienia, nazwiska, płci, stanowiska, producenta
- W trakcie pracy: Przycisk do dodawnia , usuwania , edycji danych pracownika 

#### Zakładka z produktami:
- W przygotowaniu…

#### Lista rezerwacji produktów:
- Tabela z listą zarezerwowanych produktów
- Przycisk do dodawnia , usuwania , edycji rezerwacji

## Technicznie:
### Baza danych
- Tabela Pracownicy
- Tabela Prodecent
- Tabela Produkty
- Tabela Dostawa
- Tabela Kategorie
- Tabela Klienci
- Tabela Koszyk
- Tabela Opiekun_produktu
- Tabela Rabaty 
- Tabela Rezerwacje_produktów
- Tabela Statusy 
- Tabel Wybrane_produkty

### ORM + operacje na bazie
- Dodawanie rekordów do bazy
- Usuwanie rekordów
- Pobieranie rekordów jako dane

# Instalacja projektu w wersji deweloperskiej

## Pliki
- Skrypt SQL
- Plik projektowy

## Wymagania
- Visual Studio 2019 z .NET 5.0
- MS SQL Server

## Instalacja

Do uruchomienia aplikacji nasz serwer SQL musi być widoczny pod adresem "**.**". Następnie urachamiamy dołączony skrypt. Po dodaniu bazy danych przechodzimy do pliku projektowego. Po wkonaniu wszystkich poprzednich operacji uruchamiamy Projekt.sln i aplikajca jest gotowa do użycia.

## Problemy z połączeniem do bazy

Sprawdzić wpis odnośnie bazy danych w pliku: SklepInternetowy_BAJTContext.cs -- optionsBuilder.UseSqlServer("Server=XXXXXXXX; ....)

