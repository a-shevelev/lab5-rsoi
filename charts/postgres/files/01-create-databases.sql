CREATE DATABASE reservations;
CREATE DATABASE libraries;
CREATE DATABASE ratings;

\c libraries

CREATE TABLE IF NOT EXISTS library
(
    id          SERIAL PRIMARY KEY,
    library_uid UUID UNIQUE NOT NULL,
    name        VARCHAR(80) NOT NULL,
    city        VARCHAR(255) NOT NULL,
    address     VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS books
(
    id        SERIAL PRIMARY KEY,
    book_uid  UUID UNIQUE NOT NULL,
    name      VARCHAR(255) NOT NULL,
    author    VARCHAR(255),
    genre     VARCHAR(255),
    condition VARCHAR(20) DEFAULT 'EXCELLENT'
    CHECK (condition IN ('EXCELLENT', 'GOOD', 'BAD'))
    );

CREATE TABLE IF NOT EXISTS library_books
(
    book_id         INT REFERENCES books(id),
    library_id      INT REFERENCES library(id),
    available_count INT NOT NULL
    );

INSERT INTO library (id, library_uid, name, city, address)
VALUES (
           1,
           '83575e12-7ce0-48ee-9931-51919ff3c9ee',
           'Библиотека имени 7 Непьющих',
           'Москва',
           '2-я Бауманская ул., д.5, стр.1'
       );

INSERT INTO books (id, book_uid, name, author, genre, condition)
VALUES (
           1,
           'f7cdc58f-2caf-4b15-9727-f89dcc629b27',
           'Краткий курс C++ в 7 томах',
           'Бьерн Страуструп',
           'Научная фантастика',
           'EXCELLENT'
       );

INSERT INTO library_books (book_id, library_id, available_count)
VALUES (1, 1, 1);


\c reservations

CREATE TABLE IF NOT EXISTS reservation
(
    id              SERIAL PRIMARY KEY,
    reservation_uid UUID UNIQUE NOT NULL,
    username        VARCHAR(80) NOT NULL,
    book_uid        UUID NOT NULL,
    library_uid     UUID NOT NULL,
    status          VARCHAR(20) NOT NULL
    CHECK (status IN ('RENTED', 'RETURNED', 'EXPIRED')),
    start_date      TIMESTAMP NOT NULL,
    till_date       TIMESTAMP NOT NULL
    );



\c ratings

CREATE TABLE IF NOT EXISTS rating
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(80) NOT NULL,
    stars    INT NOT NULL
    CHECK (stars BETWEEN 0 AND 100)
    );

INSERT INTO rating (username, stars)
VALUES ('Test Max', 75),
       ('auth0|694550e3427eb2c33e5671d4', 75);
