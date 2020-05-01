CREATE DATABASE netto;

CREATE TABLE cards (
    id SERIAL PRIMARY KEY,
    name TEXT,
    image TEXT,
    workplace TEXT,
    job TEXT,
    met TEXT,
    source INTEGER,
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


INSERT INTO cards (name, image, workplace, job, met, source, skills, quality, notes, user_id) VALUES (),

ALTER TABLE 'cards'
RENAME COLUMN "relationship" TO "source";

create_card('Henry Fee', "", "the sky", "counter", "at the pub", "Kevin Garcia", "knifes", "great guy", "awudhaodawdohao", 3)

INSERT INTO cards (name, image, workplace, job, met, source, skills, quality, notes, user_id) VALUES ('Nil Brown', "", "the sky", "counter", "at the pub", nil, "knifes", "great guy", "awudhaodawdohao", 3);