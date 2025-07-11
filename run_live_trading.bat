@echo off
:: Set up logging
set LOGFILE=%USERPROFILE%\live_trading.log
echo Logging execution details to %LOGFILE%

:: Ensure Python is installed
where python >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python from https://www.python.org/.
    exit /b
)

:: Install required Python libraries
echo Installing required libraries...
python -m pip install --upgrade pip
pip install yfinance >nul 2>nul

:: Run the live trading Python script
echo Running the live trading bot...
python "C:\Users\Administrator\live_trading_bot.py"

:: Wrap up
echo All tasks completed. Check log at %LOGFILE%.
