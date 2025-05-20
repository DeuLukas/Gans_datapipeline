# GANS - A cloud-based data pipeline for weather and flight info for select cities.
As part of my journey in WBS coding school's data science bootcamp, project GANS is about - fictive - company that offers e-scooters in various cities wants to optimize their scooter-redeployment patterns. They found that the number of arriving airplanes and weather have a large influence on how customers use their e-scooters and how fast they agglomerate in different parts of a city. This project aims to create an ETL pipeline using GoogleCloud to enable on-demand data usage for analysis and forecasting by gathering weather and flight info for cities with (multiple) airports. During the project I grew my data engineering toolkit by setting up SQL schemas and filling it with a combination of webscraped and API-retrieved data to deliver a clean and structured data warehouse that is cloud-hosted and features scheduled updates. 

## Getting started
The used software includes an environment capable of utlizing IPython Notebooks, MySQL Workbench 8, Google Web Services (free plan). When setting up the IPython Notebooks, store your API keys from https://openweathermap.org/ (free plan) and https://rapidapi.com/aedbx-aedbx/api/aerodatabox (free plan - caution with limited API calls) in the `.env` file as well as your SQL root passowrd. In MySQL create the empty database structure by running the `gans_table_creation.sql` script. Afterwards work your way through the `database_setup.ipynb` notebook. The different sections include the functions to perform database creation, data collection and transfer tasks as well as manual updates both locally and for cloud storage. The `Local_test_...` notebooks can be utilized for testing and trouble shooting cloud functionality. Connectivity-relevant information should be stored in the `con_cloud.py` and `con_local.py` files. 

## Data Warehouse creation 🗄️
### Webscraping with BeautifulSoup📍
The first task revolved around figuring out basic data about select cities. Using city names will prompt the algorithm to find out city-centre coordinates and other population data for the cities of interest. Functionality is achieved by analyzing html structure of wikipedia's website for select city names. Wikipedia has inconsistent practices for storing population data and census timestamps. When the used webscraping routine fails, -999 is inserted to indicate a missing value without throwing an error as the main data objective is the geolocation. 

### Setting up the data tables 📁
The core table of the database is the city table providing next to geo-data and name of the city the 'city_id' value which served as primary key and connects the cities with the associated 'weather', 'cities-airports' and the optional 'population' tables. To utilize the static city_id it's reimported from SQL to Python after setting up static tables to ensure connectivity between tables. The image below highlights general structure of the static core of 'city', 'city-airports' and 'airports' tables with dynamic weather and flights tables.
![image](https://github.com/user-attachments/assets/a21ae1d5-9fb5-42a5-9c06-823f5455d26b)

### Retrieving weather data ☀️
Using a free weather API by openweather ( https://openweathermap.org/forecast5 ) provides weather forecasts in 3 hour intervals for 5 days in total. Select weather parameters are temperature (in °C), the felt temperature (in °C), sky coverage, average wind speed (in kph) and rain within the last 3 hours (in mm). Using the unique city_id, the forecast time interval and data retrieval timestamp allow for further analysis.

### Fetching Airport and Flight data 🛬
Utilizing RapidAPI's Basic plan, we use the Airport API's `Search Airports by location` to find all active airports within a select radius around the scraped coordinates for the cities. For each of the airports associated with a city we utilize the unique ICAO identifier to access the Flights API's `FIDS: Airport Departures and Arrivals (By Time Range)` features within the AeroDataBox. They share same API code. The script finds all arrivals for the next day when executed. 

### Setting up Google Cloud ☁️
To achieve cloud functionality I recommend reading or watching one of the many good (video) tutorials that explain how to setup GoogleCloud functions and a Cloud Scheduler. Content of the cloud executed functions are the corresponding fields in the `Local_test_flights.ipynb` and `Local_test_weather.ipynb` notebooks. 

## Utilized toolkit 🔨
- Python
  - Pandas
  - BeautifulSoup
  - Requests (Processing JSON formatted API retrievals)
- MySQL
- Google Cloud Services
