# BharatWeatherLogger

### Real-time Weather Logging for Indian Cities

**BharatWeatherLogger** is a command-line tool that allows you to fetch real-time weather data for major Indian cities. The data is logged, including observed and forecast temperatures, weather conditions, humidity, and wind speed, with an option to select temperature units (Celsius or Fahrenheit).

---

## Features

- Fetch real-time weather data for any of the major Indian cities.
- Logs data to a file including the city name, observed temperature, forecast temperature, weather condition, humidity, and wind speed.
- Option to choose between Celsius and Fahrenheit for temperature readings.
- Supports daily, 3-day, and weekly weather forecasts.

## Prerequisites

- `curl` command-line tool installed on your system to fetch weather data from the web.
- A Unix-based OS (Linux, macOS, or Windows Subsystem for Linux) for best compatibility.

---

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/AshNicolus/IndiaCast.git
    cd BharatWeatherLogger
    ```

2. **Make the script executable:**
    ```bash
    chmod u+x main_rx.sh
    ```

---

## How to Use

1. **Run the script:**
    ```bash
    ./main_rx.sh
    ```

2. **Input the city and forecast preferences when prompted:**
   - Enter an Indian city (e.g., Mumbai, Delhi, Bangalore, etc.).
   - Choose the forecast period (1 day, 3 days, or weekly).
   - Choose the desired temperature unit (C for Celsius or F for Fahrenheit).

3. **After running, the script will fetch weather data and log it to a file named `rx_poc.log`.**

---

## Example

When you run the script for the city of Mumbai with a 1-day forecast and temperature in Celsius, the following data might be logged:

