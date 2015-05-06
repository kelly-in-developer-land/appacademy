DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname string NOT NULL,
  lname string NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title string NOT NULL,
  body string NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  parent_id INTEGER REFERENCES replies(id),
  body string NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  user_id INTEGER NOT NULL REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Carlos', 'Carrera');

INSERT INTO
  users(fname, lname)
VALUES
  ('Kelly', 'Witwicki');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Using BART', 'Does anyone know how to use public transit?', 1);

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Lunch', 'Where is the falafel?', 2);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (1, 2);

INSERT INTO
  replies(question_id, user_id, body)
VALUES
  (2, 1, 'Go downstairs!');

INSERT INTO
  replies(question_id, user_id, parent_id, body)
VALUES
  (2, 2, 1, 'Thanks Carlos!');

INSERT INTO
  question_likes(likes, question_id, user_id)
VALUES
  (5, 2, 1);
