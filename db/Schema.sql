CREATE DATABASE netto;

CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    name TEXT,
    image TEXT,
    workplace TEXT,
    job TEXT,
    met TEXT,
    relationship TEXT,
    skills TEXT,
    quality TEXT,
    notes TEXT,
    user_id INTEGER
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    pw_digest TEXT
);

INSERT INTO users (email, pw_digest) VALUES ('user@netto.com', 'qwe');
INSERT INTO users (email) VALUES ('t@t.com');


INSERT INTO cards (name, image, workplace, job, met, relationship, skills, quality, notes, user_id) VALUES (),
