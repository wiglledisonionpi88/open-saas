import requests
import base64
import pandas as pd
import numpy as np
import yfinance as yf
import ta
import backtrader as bt
from datetime import datetime

WIGLE_API_NAME = "AID13ef5a10b5e2ba7dcd2da67dc367efe7"
WIGLE_API_TOKEN = "f09a49be681a4bb8ba8105cc69e7b9d9"

def fetch_wigle_data():
    headers = {"Authorization": "Basic " + base64.b64encode(f"{WIGLE_API_NAME}:{WIGLE_API_TOKEN}".encode()).decode()}
    response = requests.get("https://api.wigle.net/api/v2/profile/user", headers=headers)
    if response.status_code == 200:
        print("Successfully fetched WiGLE data:", response.json())
        return response.json()
    else:
        print(f"Error fetching WiGLE data: {response.status_code}")
        return None

def fetch_market_data(ticker):
    print(f"Fetching historical data for {ticker}...")
    df = yf.download(ticker, start="


@echo off
:: Log file setup
set LOGFILE=%USERPROFILE%\trading_bot.log
echo Logging execution details to %LOGFILE%

:: Ensure Python is installed
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python from https://www.python.org/.
    exit /b
)

:: Install Python dependencies
echo Installing required Python libraries...
python -m pip install