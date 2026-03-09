#!/usr/bin/env python3
import json
import requests

LAT = -7.4928
LON = -38.9850

ICON = {
    0: "☀️",  # Clear sky
    1: "🌤",  # Mainly clear
    2: "⛅",  # Partly cloudy
    3: "☁️",  # Overcast
    45: "🌫",  # Fog
    48: "🌫",
    51: "🌦",  # Light drizzle
    53: "🌦",
    55: "🌧",
    61: "🌦",  # Rain
    63: "🌧",
    65: "🌧",
    71: "🌨",  # Snow
    80: "🌦",
    81: "🌧",
    82: "🌧",
    95: "⛈",
    96: "⛈",
    99: "⛈",
}

url = f"https://api.open-meteo.com/v1/forecast?latitude={LAT}&longitude={LON}&current=temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=America/Fortaleza"

try:
    weather = requests.get(url, timeout=5).json()

    current = weather["current"]
    daily = weather["daily"]

    temp = int(current["temperature_2m"])
    code = int(current["weather_code"])

    data = {
        "text": f"{ICON.get(code, '❓')} {temp}°",
        "tooltip": (
            f"<b>Weather Now</b>\n"
            f"Temp: {temp}°C\n"
            f"Humidity: {current['relative_humidity_2m']}%\n"
            f"Wind: {current['wind_speed_10m']} km/h\n\n"
            f"<b>Today</b>\n"
            f"⬆️ {daily['temperature_2m_max'][0]}° ⬇️ {daily['temperature_2m_min'][0]}°\n"
            f"🌅 {daily['sunrise'][0].split('T')[1]}  🌇 {daily['sunset'][0].split('T')[1]}"
        ),
    }

except Exception as e:
    data = {"text": "⚠️", "tooltip": f"Error: {e}"}

print(json.dumps(data))
