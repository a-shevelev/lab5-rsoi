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
