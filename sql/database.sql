-- psql -f sql/database.sql

DROP DATABASE IF EXISTS consumerlawyer;
CREATE DATABASE consumerlawyer;

\c consumerlawyer;

CREATE TYPE user_type AS ENUM ('consumer', 'lawyer');

CREATE EXTENSION pgcrypto;

CREATE TABLE login_detail (
  ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id VARCHAR UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  type user_type NOT NULL
);

INSERT INTO login_detail (user_id, password, type)
  VALUES ('ravi', 'password123', 'consumer');

INSERT INTO login_detail (user_id, password, type)
  VALUES ('ravi01', 'password123', 'consumer');

INSERT INTO login_detail (user_id, password, type)
  VALUES ('ravi_l', 'password123', 'lawyer');

INSERT INTO login_detail (user_id, password, type)
  VALUES ('ravi_l01', 'password123', 'lawyer');

CREATE TABLE user_detail (
  ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id VARCHAR REFERENCES login_detail(user_id) ON DELETE CASCADE,
  email VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR,
  middle_name VARCHAR,
  sex VARCHAR,
  title VARCHAR
);

INSERT INTO user_detail (user_id, email, first_name, last_name, middle_name, sex, title)
  VALUES ('ravi', 'rbojha008@gmail.com', 'ravi', 'ojha', '', 'male', 'mr');