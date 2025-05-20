#config.py
import os
from dotenv import load_dotenv

#load environment variables from .env file
load_dotenv()

# root configuration
SQL_ROOT = os.getenv('SQL_ROOT')
# API key for Openweathermap.org
OPENWEATHER_API_KEY = os.getenv('OPENWEATHER_API_KEY')
# Rapid API for Airport by location and Airport departures
RAPID_API_KEY = os.getenv('RAPID_API_KEY')
