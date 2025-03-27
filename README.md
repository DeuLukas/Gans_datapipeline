# Cloud-based data pipeline for weather and flights
Creating an ETL data pipeline that supplies weather, airport and flight arrival data for select cities
As part of my datascience bootcamp a case study specifies the above requirements for subsequent data analysis for a fictional e-scooter company that aims to analyze and improve their scooter redeployment strategy. The project aims to pick up data engineering skills by setting up SQL schemas and filling it with a combination of webscraped and API data to deliver a clean and structured data warehouse that is cloud-hosted and auto-updated using google cloud. 
For google cloud automation local test code is provided in a Jupyter Notebook for both weather and flights data. Setting up google secrets and specifying all required packages in google cloud functions is required for full functionality. Surrounding steps in google cloud may require further tutorials for users that are inexperienced in google cloud. 
For local usage a .env file storing SQL root password and API keys paired with a config.py file enable operation without exposing sensitive information. Connection to SQL is enabled with associated .py files containing connection strings to be specified by the user.
In the following, the database creation is guided in chronological order. 

## Webscraping with BeautifulSoup
The first task revolves around figuring out basic data about select cities. Using city names will prompt the algorithm to find out city-centre coordinates and other population data for the cities of interest. Functionality is achieved by analyzing html structure of wikipedia's website for select cities. There are cities where functionality for population data and year of census are stored differently. In those cases -999 is inserted to indicate a missing value as long as the main goal of geolocation webscraping is achieved. 

## Setting up the different data tables
The core table of the database is the city table providing next to geo-data and name of the city the 'city_id' value which served as primary key and connects the cities with the associated 'weather', 'cities-airports' and the optional 'population' tables. To utilize the static city_id it's reimported from SQL to Python after setting up static tables to ensure connectivity between tables. The image below highlights general structure of the static core of 'city', 'city-airports' and 'airports' tables with dynamic weather and flights tables.
![image](https://github.com/user-attachments/assets/a21ae1d5-9fb5-42a5-9c06-823f5455d26b)

## Retrieving weather data
Using a free weather API by openweather ( https://openweathermap.org/forecast5 ) provides weather forecasts in 3 hour intervals for 5 days in total. Select weather parameters are temperature (in °C), the felt temperature (in °C), sky coverage, average wind speed (in kph) and rain within the last 3 hours (in mm). In cases of no rain no data is returned by the API, '0' is then assigned as a default alternative. Using the unique city_id, the forecast time interval and data retrieval timestamp allow for further analysis.

