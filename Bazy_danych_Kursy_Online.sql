-- Tworzenie bazy danych
CREATE DATABASE IF NOT EXISTS kursy_online;
USE kursy_online;

-- Tabela użytkownicy
CREATE TABLE IF NOT EXISTS uzytkownicy (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    rola ENUM('student', 'nauczyciel') NOT NULL
);

-- Tabela kursy
CREATE TABLE IF NOT EXISTS kursy (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(100) NOT NULL,
    opis TEXT,
    id_nauczyciela INT,
    FOREIGN KEY (id_nauczyciela) REFERENCES uzytkownicy(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabela zapisane_kursy (relacja wiele-do-wielu)
CREATE TABLE IF NOT EXISTS zapisane_kursy (
    id_uzytkownika INT,
    id_kursu INT,
    data_zapisu DATE NOT NULL,
    PRIMARY KEY (id_uzytkownika, id_kursu),
    FOREIGN KEY (id_uzytkownika) REFERENCES uzytkownicy(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_kursu) REFERENCES kursy(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Przykładowe dane użytkowników
INSERT INTO uzytkownicy (imie, nazwisko, email, rola) VALUES
('Anna', 'Kowalska', 'anna.kowalska@gamil.com', 'nauczyciel'),
('Jan', 'Nowak', 'jan.nowak@gmail.com', 'student'),
('Ewa', 'Wiśniewska', 'ewa.wisniewska@gmail.com', 'student');


-- Przykładowe kursy (przypisane do nauczyciela Anna)
INSERT INTO kursy (nazwa, opis, id_nauczyciela) VALUES
('Podstawy SQL', 'Nauka podstaw języka SQL', 1),
('Zaawansowane bazy danych', 'Normalizacja, relacje, indeksy', 1);

-- Przykładowe zapisy studentów na kursy
INSERT INTO zapisane_kursy (id_uzytkownika, id_kursu, data_zapisu) VALUES
(2, 1, '2025-04-01'),
(2, 2, '2025-04-10'),
(3, 1, '2025-04-05');


-- Lista wszystkich użytkowników 
SELECT * FROM uzytkownicy;

-- Lista wszystki kursów z nawiązaniem do nauczyciela
SELECT 
    k.id,
    k.nazwa AS nazwa_kursu,
    CONCAT(u.imie, ' ', u.nazwisko) AS nauczyciel
FROM kursy k
JOIN uzytkownicy u ON k.id_nauczyciela = u.id;

-- lista studentów zapisanych na kurs
SELECT 
    zk.data_zapisu,
    CONCAT(s.imie, ' ', s.nazwisko) AS student,
    k.nazwa AS kurs
FROM zapisane_kursy zk
JOIN uzytkownicy s ON zk.id_uzytkownika = s.id
JOIN kursy k ON zk.id_kursu = k.id
WHERE s.rola = 'student';


-- kto jest zapisany na konkrenty kurs
SELECT 
    k.nazwa AS kurs,
    CONCAT(u.imie, ' ', u.nazwisko) AS student,
    zk.data_zapisu
FROM zapisane_kursy zk
JOIN uzytkownicy u ON zk.id_uzytkownika = u.id
JOIN kursy k ON zk.id_kursu = k.id
WHERE k.nazwa = 'Podstawy SQL';

-- dodawanie nauczycieli
INSERT INTO uzytkownicy (imie, nazwisko, email, rola) VALUES
('Marek', 'Zieliński', 'marek.zielinski@example.com', 'nauczyciel'),
('Katarzyna', 'Nowicka', 'katarzyna.nowicka@example.com', 'nauczyciel');

-- dodawanie kursów

INSERT INTO kursy (nazwa, opis, id_nauczyciela) VALUES
('Python dla początkujących', 'Kurs wprowadzający do programowania w Pythonie', 4),
('HTML i CSS', 'Tworzenie stron internetowych od podstaw', 5);

-- dodawanie nowych studentów

INSERT INTO uzytkownicy (imie, nazwisko, email, rola) VALUES
('Tomasz', 'Lis', 'tomasz.lis@gmail.com', 'student'),
('Magdalena', 'Mazur', 'magdalena.mazur@gmail.com', 'student'),
('Piotr', 'Kowalczyk', 'piotr.kowalczyk@gmail.com', 'student'),
('Julia', 'Dąbrowska', 'julia.dabrowska@gmail.com', 'student'),
('Adam', 'Szymański', 'adam.szymanski@gmail.com', 'student');

-- zapisywanie studentów na kurs

INSERT INTO zapisane_kursy (id_uzytkownika, id_kursu, data_zapisu) VALUES
(6, 3, '2025-04-12'),  
(7, 4, '2025-04-13'),  
(8, 1, '2025-04-14'),  
(9, 2, '2025-04-15'), 
(10, 3, '2025-04-16'); 







