-- notes on how my database is set up

CREATE DATABASE vinyl;

\c vinyl

CREATE TABLE records
(
  id serial4,
  title varchar(140),
  artist varchar(140)
);

INSERT INTO records (title, author) VALUES ('Kind Of Blue', 'Miles Davis');

INSERT INTO records (title, author) VALUES ('The Blue Album', 'Weezer');  
  
INSERT INTO records (title, author) VALUES ('Start Breaking My Heart', 'Manitoba');
  
