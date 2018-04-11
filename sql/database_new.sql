-- psql -f sql/database_new.sql
DROP DATABASE IF EXISTS consumerlawyer;
CREATE DATABASE consumerlawyer;

\c consumerlawyer;

CREATE TYPE user_type AS ENUM ('consumer', 'lawyer');
CREATE TYPE salutation_type AS ENUM ('mr', 'mrs', 'miss');
CREATE TYPE sex_type AS ENUM ('male', 'female');
CREATE TYPE work_destination AS ENUM ('lawyer', 'engineer', 'doctor', 'police', 'businees_man', 'other');
CREATE TYPE status AS ENUM ('in_progress', 'accepted', 'rejected');
CREATE EXTENSION pgcrypto;

create function now_utc() returns timestamp as $$
  select now() at time zone 'utc';
$$ language sql;

CREATE TABLE user (
	ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	user_id VARCHAR UNIQUE NOT NULL,
	user_type user_type NOT NULL,
	password VARCHAR NOT NULL,
	email VARCHAR,
	salutation salutation_type,
	country VARCHAR NOT NULL,
	state VARCHAR NOT NULL,
	address VARCHAR,
	sex sex_type NOT NULL,
	first_name VARCHAR NOT NULL,
	middle_name VARCHAR,
	last_name VARCHAR NOT NULL,
	last_login VARCHAR DEFAULT now_utc(),
	last_logout VARCHAR
);

CREATE TABLE lawyer_details (
	ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	user_id VARCHAR REFERENCES user(user_id) ON DELETE CASCADE,
	introduction VARCHAR,
	win_case INTEGER,
	lost_case INTEGER,
	pending_case INTEGER,
	expertise VARCHAR,
	other_area VARCHAR
);

CREATE TABLE compalains (
	ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	short_description VARCHAR,
	long_description VARCHAR,
	compalain_type VARCHAR
);