DROP DATABASE IF EXISTS consumerlawer;
CREATE DATABASE consumerlawer;

\c consumerlawer;

CREATE TABLE login_detail (
  ID SERIAL PRIMARY KEY,
  name VARCHAR
);

INSERT INTO login_detail (name)
  VALUES ('Ravi');
