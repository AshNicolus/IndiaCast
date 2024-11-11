#!/bin/bash

# Get today's date in YYYYMMDD format
today=$(date +%Y%m%d)

# List of major Indian cities
INDIAN_CITIES=("Mumbai" "Delhi" "Bangalore" "Hyderabad" "Ahmedabad" "Chennai" "Kolkata" "Pune" "Jaipur" "Lucknow")

# Ask the user for city and forecast preference
read -p "Enter an Indian city for the weather report: " city
read -p "Enter forecast days (1 for today, 3 for next 3 days, 7 for weekly): " forecast_days
read -p "Temperature units (C for Celsius, F for Fahrenheit): " temp_unit

# Verify city is valid
if [[ ! " ${INDIAN_CITIES[@]} " =~ " ${city} " ]]; then
    echo "Error: $city is not a recognized Indian city. Exiting."
    exit 1
fi

# Validate temperature unit
temp_unit="${temp_unit^^}"  # Convert to uppercase
if [[ "$temp_unit" != "C" && "$temp_unit" != "F" ]]; then
    echo "Error: Invalid temperature unit. Use 'C' or 'F'. Exiting."
    exit 1
fi

# Build request parameters
request="wttr.in/$city?${forecast_days}&u=${temp_unit}"

# Fetch weather data
curl -s "$request" --output weather_report
if [[ $? -ne 0 ]]; then
    echo "Error: Unable to fetch weather data."
    exit 1
fi

# Parse data for temperatures, condition, humidity, wind speed
obs_tmp=$(grep -m 1 "°$temp_unit" weather_report | tr -s " " | xargs | rev | cut -d " " -f2 | rev)
fc_temp=$(grep -m 3 "°$temp_unit" weather_report | tail -1 | tr -s " " | xargs | cut -d "$temp_unit" -f2 | rev | cut -d " " -f2 | rev)
condition=$(grep -oP "(Cloudy|Clear|Rain|Sunny|Partly cloudy|Storm)" weather_report | head -1)
humidity=$(grep -oP "Humidity.*?%" weather_report | head -1 | cut -d ":" -f2 | xargs)
wind_speed=$(grep -oP "Wind.*?km/h" weather_report | head -1 | cut -d ":" -f2 | xargs)

# Date and time info in local timezone
hour=$(date +%H)
day=$(date +%d)
month=$(date +%m)
year=$(date +%Y)

# Format record and append to log file
record=$(echo -e "$year\t$month\t$day\t$hour\t$city\t$obs_tmp\t$fc_temp\t$condition\t$humidity\t$wind_speed")
echo $record >> rx_poc.log

# Display summary to user
echo "Weather data for $city recorded in rx_poc.log"
echo -e "Summary:\nCity: $city\nObserved Temp: $obs_tmp°$temp_unit\nForecast Temp: $fc_temp°$temp_unit\nCondition: $condition\nHumidity: $humidity\nWind Speed: $wind_speed"
