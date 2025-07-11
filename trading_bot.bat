@echo off
:: Setup log file
set LOGFILE=%USERPROFILE%\trading_bot.log
echo Logging execution details to %LOGFILE%

:: Ensure Python is installed
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python from https://www.python.org/.
    exit /b
)

:: Write Python script to file
echo Writing the trading bot script to %USERPROFILE%\trading_bot.py...
(
echo import requests
echo import base64
echo import pandas as pd
echo import numpy as np
echo import yfinance as yf
echo import ta
echo import backtrader as bt
echo from datetime import datetime
echo.
echo WIGLE_API_NAME = "AID13ef5a10b5e2ba7dcd2da67dc367efe7"
echo WIGLE_API_TOKEN = "f09a49be681a4bb8ba8105cc69e7b9d9"
echo.
echo def fetch_wigle_data():
echo     headers = {"Authorization": "Basic " + base64.b64encode(f"{WIGLE_API_NAME}:{WIGLE_API_TOKEN}".encode()).decode()}
echo     response = requests.get("https://api.wigle.net/api/v2/profile/user", headers=headers)
echo     if response.status_code == 200:
echo         print("Successfully fetched WiGLE data:", response.json())
echo         return response.json()
echo     else:
echo         print(f"Error fetching WiGLE data: {response.status_code}")
echo         return None
echo.
echo def fetch_market_data(ticker):
echo     print(f"Fetching historical data for {ticker}...")
echo     df = yf.download(ticker, start="2022-01-01", end="2024-01-01")
echo     if df.empty:
echo         print("No market data available.")
echo         return None
echo     return df
echo.
echo def fibonacci_levels(df):
echo     max_price = df["High"].max()
echo     min_price = df["Low"].min()
echo     diff = max_price - min_price
echo     levels = {
echo         "0%%": max_price,
echo         "23.6%%": max_price - 0.236 * diff,
echo         "38.2%%": max_price - 0.382 * diff,
echo         "61.8%%": max_price - 0.618 * diff,
echo         "100%%": min_price
echo     }
echo     print("Fibonacci Levels:", levels)
echo     return levels
echo.
echo class TradingStrategy(bt.Strategy):
echo     params = (("ema_short", 9), ("ema_long", 21))
echo.
echo     def __init__(self):
echo         self.ema_short = bt.indicators.EMA(period=self.params.ema_short)
echo         self.ema_long = bt.indicators.EMA(period=self.params.ema_long)
echo.
echo     def next(self):
echo         if self.ema_short[0] > self.ema_long[0] and not self.position:
echo             self.buy()
echo             print("Buy Signal Triggered")
echo         elif self.ema_short[0] < self.ema_long[0] and self.position:
echo             self.sell()
echo             print("Sell Signal Triggered")
echo.
echo def run_backtest(ticker):
echo     cerebro = bt.Cerebro()
echo     data = fetch_market_data(ticker)
echo     if data is None or data.empty:
echo         print("No data available. Skipping backtest.")
echo         return
echo     bt_data = bt.feeds.PandasData(dataname=pd.DataFrame(data))
echo     cerebro.adddata(bt_data)
echo     cerebro.addstrategy(TradingStrategy)
echo     print("Running backtest iterations...")
echo     for i in range(20):
echo         print(f"Iteration {i+1}/20")
echo         cerebro.run()
echo     print("Backtest Complete!")
echo.
echo wigle_data = fetch_wigle_data()
echo if wigle_data:
echo     print("WiGLE User ID:", wigle_data.get("userid"))
echo ticker = "BTC-USD"
echo market_data = fetch_market_data(ticker)
echo if market_data is not None:
echo     fibonacci_levels(market_data)
echo     run_backtest(ticker)
echo print("Trading bot execution completed.")
) > %USERPROFILE%\trading_bot.py

:: Install Python dependencies
echo Installing required Python libraries...
python -m pip install --upgrade pip
pip install pandas yfinance numpy ta backtrader requests >nul 2>nul

:: Run the Python script
echo Running the trading bot...
python %USERPROFILE%\trading_bot.py

:: Finish execution
echo All tasks completed. Check %LOGFILE% for details.
