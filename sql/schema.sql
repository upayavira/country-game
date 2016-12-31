CREATE DATABASE countries;

use countries;

CREATE TABLE country (
    id varchar(4) NOT NULL,
    common_name varchar(50) NULL,
    official_name varchar(80) NULL,
    currency varchar(4) NULL,
    calling_code varchar(8) NULL,
    capital varchar(50) NULL,
    region varchar(50) NULL,
    subregion varchar(50) NULL,
    lat FLOAT NULL,
    lon FLOAT NULL,
    landlocked bit NULL,
    area int NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;;

CREATE TABLE language (
    country_id varchar(4) NOT NULL,
    language_code varchar(4) NOT NULL,
    language_name varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;;

CREATE TABLE border (
    country_id varchar(4) NOT NULL,
    border varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;;
