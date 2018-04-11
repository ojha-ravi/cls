-- psql -f sql/database.sql
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

CREATE TABLE user_detail (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id VARCHAR UNIQUE NOT NULL,
    user_type user_type NOT NULL,
    password VARCHAR NOT NULL,
    email VARCHAR,
    title VARCHAR,
    sex sex_type NOT NULL,
    first_name VARCHAR NOT NULL,
    middle_name VARCHAR,
    last_name VARCHAR NOT NULL,
    last_login VARCHAR NOT NULL,
    last_logout VARCHAR
);

INSERT INTO
    user_detail (user_id, user_type, password, title, sex, first_name, middle_name, last_name, last_login)
VALUES
    ('test_c', 'consumer', 'password123' , 'mr', 'male', 'alpha', 'beta', 'gama', now_utc());

INSERT INTO
    user_detail (user_id, user_type, password, title, sex, first_name, middle_name, last_name, last_login)
VALUES
    ('test_l', 'lawyer', 'password123' , 'mr', 'male', 'alpha', 'beta', 'gama', now_utc());

CREATE TABLE user_profile (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id VARCHAR REFERENCES user_detail(user_id) ON DELETE CASCADE,
    work_destination VARCHAR,
    introduction VARCHAR NOT NULL,
    address_1 VARCHAR,
    address_2 VARCHAR,
    address_3 VARCHAR,
    profile_image VARCHAR
);

INSERT INTO
    user_profile (user_id, work_destination, introduction, address_1, address_2, address_3, profile_image)
VALUES
    (
		'test_l', 'lawyer',
		'As it so contrasted oh estimating instrument. Size like body some one had. Are conduct viewing boy minutes warrant expense. Tolerably behaviour may admitting daughters offending her ask own. Praise effect wishes change way and any wanted. Lively use looked latter regard had. Do he it part more last in. Merits ye if mr narrow points. Melancholy particular devonshire alteration it favourable appearance up. ',
		'bangalore',
        '',
        '',
		'ravi.png'
	);

INSERT INTO
    user_profile (user_id, work_destination, introduction, address_1, address_2, address_3, profile_image)
VALUES
    (
		'test_c', 'engineer',
		'As it so contrasted oh estimating instrument. Size like body some one had. Are conduct viewing boy minutes warrant expense. Tolerably behaviour may admitting daughters offending her ask own. Praise effect wishes change way and any wanted. Lively use looked latter regard had. Do he it part more last in. Merits ye if mr narrow points. Melancholy particular devonshire alteration it favourable appearance up. ',
		'bangalore',
        '',
        '',
		'ravi.png'
	);

CREATE TABLE user_lawyer_profile (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id VARCHAR REFERENCES user_detail(user_id) ON DELETE CASCADE,
    expertise_in VARCHAR NOT NULL,
    other_area VARCHAR NOT NULL,
    total_experience VARCHAR,
    won_cases INTEGER,
    lost_cases INTEGER
);

CREATE TABLE user_consumer_profile (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id VARCHAR REFERENCES user_detail(user_id) ON DELETE CASCADE,
    working_as VARCHAR NOT NULL,
    total_experience VARCHAR
);

CREATE TABLE complains (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	short_description VARCHAR,
	long_description VARCHAR,
	complain_type VARCHAR,
	country VARCHAR,
	state VARCHAR,
	place VARCHAR,
	fir_filed_number BOOLEAN,
    create_by VARCHAR REFERENCES user_detail(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE file_uploaded (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    complains_id UUID REFERENCES complains(id) ON DELETE CASCADE,
	created_at TIMESTAMP
);

CREATE TABLE complains_assingment (
	ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	complains_id UUID REFERENCES complains(id) ON DELETE CASCADE,
	assigned_to VARCHAR REFERENCES user_detail(user_id) ON DELETE CASCADE,
	status status DEFAULT 'in_progress'
);
