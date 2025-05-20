/***************************
Setting up the environment
***************************/

-- Drop the database if it already exists
DROP DATABASE IF EXISTS gans_wbsproject ;

-- Create the database
CREATE DATABASE gans_wbsproject;

-- Use the database
USE gans_wbsproject;



/***************************
Creating the first table
***************************/

-- Create the 'basic info' table
CREATE TABLE city (
    city_id INT AUTO_INCREMENT, -- Automatically generated ID for each city
    city VARCHAR(255) NOT NULL, -- Name of the city
    country VARCHAR(255) NOT NULL, # country name
    latitude FLOAT, # coordinates of the city
    longitude FLOAT,
    PRIMARY KEY (city_id) -- Primary key to uniquely identify each city
);

/* An auto-increment attribute automatically generates a unique number
(typically used for a primary key) for each new record inserted into a table. */

/* A primary key is a unique identifier for each record in a database table,
ensuring that no two rows have the same value in this column. */

/* VARCHAR(255) data type can store strings of up to 255 characters, 
but strings can also be shorter than that. 
VARCHAR stands for "variable character"*/

/* NOT NULL constraint is used to specify that a column must not be NULL. 
This means that when you insert a new row into a table or update an existing row, 
you must provide a value for the column. */



/***************************
Creating the second table
***************************/

-- Create the 'population' table
CREATE TABLE population (
    city_id INT, -- Automatically generated ID for each city
    population INT NOT NULL, -- population of the city
    population_timestamp INT, -- year of the census
    retrieval_timestamp DATE, -- time of scraping the population data
    PRIMARY KEY (city_id), -- Primary key to uniquely identify each city
    FOREIGN KEY (city_id) REFERENCES city(city_id) -- Foreign key to connect each city's population data to the city info
);

/* INT is a numeric data type that stores signed integers. 
This means that INT values can represent both positive and negative whole numbers. */

/* A foreign key is a constraint that links a column in one table to a primary key in another table. */

-- Create the 'weather' table
CREATE TABLE weather (
	id INT AUTO_INCREMENT, 
    city_id INT, -- custom assigned ID for each city from basic table
    forecast_time DATETIME NOT NULL, -- Timestamp of the weather data
    outlook VARCHAR(255) NOT NULL, -- description of the sky
    temperature FLOAT, -- expected temperature for timeframe
    temperature_felt FLOAT, -- equivalent temperature under consideration of wind, humidity etc
    wind_speed FLOAT, -- average wind speed in kph
    rain_expected_mm FLOAT, -- expected amount of rain in the time span since the last forecast_time entry
    retrieval_time DATETIME NOT NULL, -- time of weather data retrieval
    PRIMARY KEY (id), -- primary key to identify each weather data entry uniquely
    FOREIGN KEY (city_id) REFERENCES city(city_id) -- Primary key to uniquely identify the city
);

-- Create the 'airports' table
CREATE TABLE airports (
    icao VARCHAR(5) NOT NULL, -- icao code for airport
    iata VARCHAR(5) NOT NULL, -- iata code for airport WARNING duplicate iata airport codes exist
    airport_name VARCHAR(255), -- name of the place where the airport is
	PRIMARY KEY (icao) -- primary key to identify each airport
);

-- Create the 'cities_airports' table
CREATE TABLE cities_airports (
	id INT AUTO_INCREMENT, 
    city_id INT, -- custom assigned ID for each city from cities table
    icao VARCHAR(5) NOT NULL, -- icao code for airport
    iata VARCHAR(5) NOT NULL, -- iata code for airport WARNING duplicate iata airport codes exist
    airport_name VARCHAR(255), -- name of the place where the airport is
    shortName VARCHAR(255), -- abbrevation of airport location
    municipalityName VARCHAR(255), -- associated city/region of the airport
    countryCode VARCHAR(255), -- country abbreviation
    timeZone VARCHAR(255), -- Timezone of the airport location
    latitude FLOAT NOT NULL, -- latitude of the airport
    longitude FLOAT NOT NULL, -- longitude of the airport
	PRIMARY KEY (id), -- primary key to identify each city-airport combination uniquely
    FOREIGN KEY (city_id) REFERENCES city(city_id), -- Primary key to uniquely identify the city
    FOREIGN KEY (icao) REFERENCES airports(icao) -- Primary key to uniquely identify the airport
);

CREATE TABLE flights (
	flight_id INT AUTO_INCREMENT, 
    flight_num VARCHAR(255), -- unique identifier of the flight
    departure_icao VARCHAR(5) NOT NULL, -- icao code for airport (from)
    arrival_icao VARCHAR(5) NOT NULL, -- icao code for airport (to)
    arrival_time DATETIME, -- time of plane arrival
    retrieval_time DATETIME, -- time of flight data parsing
	PRIMARY KEY (flight_id), -- primary key to identify each flight arrival uniquely in ascending order by arrival time
    FOREIGN KEY (arrival_icao) REFERENCES airports(icao) -- Primary key to uniquely identify the airport
);
