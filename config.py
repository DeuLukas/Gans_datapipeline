#config.py
import os
from dotenv import load_dotenv

#load environment variables from .env file
load_dotenv()

# root and API configuration
OPENWEATHER_API_KEY = os.getenv('OPENWEATHER_API_KEY')
SQL_ROOT = os.getenv('SQL_ROOT')
AIRPORT_GEO_API_KEY = os.getenv('AIRPORT_GEO_API_KEY')
RAPID_API_WBS = os.getenv('RAPID_API_WBS')
