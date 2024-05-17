import requests
from datetime import datetime
import mysql.connector

mydb = mysql.connector.connect(
    user='USERNAME',
    password='PASSWORD',
    host='127.0.0.1',
    database='database_name'
)
mycursor = mydb.cursor()

link = "https://api.openweathermap.org/data/2.5/forecast"
current_date = datetime.today()
formatted_date = datetime.strptime(current_date.strftime("%m/%d/%Y"), "%m/%d/%Y")

# ------------- #
cairo_lat = 30.052723
cairo_long = 31.295218
alex_lat = 31.177504
alex_long = 29.964329
aswan_lat = 24.077328
aswan_long = 32.86624
sharm_lat = 27.94376
sharm_long = 34.295376
zag_lat = 30.615112
zag_long = 31.4841
cairo_key = ''
alex_key = ""
aswan_key = ""
sharm_key = ""
zag_key = ""
# ------------- #
cairo = {
    "lat":cairo_lat,
    "lon":cairo_long,
    "appid":cairo_key,
    "units":"metric",
}
alex = {
    "lat":alex_lat,
    "lon":alex_long,
    "appid":alex_key,
    "units":"metric",
}
aswan = {
    "lat":aswan_lat,
    "lon":aswan_long,
    "appid":aswan_key,
    "units":"metric",
}
sharm = {
    "lat":sharm_lat,
    "lon":sharm_long,
    "appid":sharm_key,
    "units":"metric",
}
zagazig = {
    "lat":zag_lat,
    "lon":zag_long,
    "appid":zag_key,
    "units":"metric",
}
cities_parameters = [cairo, alex, aswan, sharm, zagazig]
i = 0

for params in cities_parameters:
    res = requests.get(link, params=params)
    print(res.raise_for_status())
    weather_data = res.json()
    # Extract data from the API response
    temp_min = float(weather_data["list"][1]["main"]["temp_min"])
    temp_max = float(weather_data["list"][4]["main"]["temp_max"])
    temp_mean = float(weather_data["list"][2]["main"]["temp"])
    apparent_temperature_mean = float(weather_data["list"][2]["main"]["feels_like"])
    sunrise = datetime.utcfromtimestamp(weather_data["city"]["sunrise"]).strftime('%H:%M:%S')
    sunset = datetime.utcfromtimestamp(weather_data["city"]["sunset"]).strftime('%H:%M:%S')
    wind_speed_max = weather_data["list"][2]["wind"]["speed"]
    try:
        rain_sum = weather_data["list"][2]["rain"]["3h"]
    except KeyError:
        rain_sum = 0
    names = ["cairo", "alex", "aswan", "sharm", "zagazig"]
    # insert data into the table
    sql = f"INSERT INTO {names[i]} (date, temperature_max, temperature_min, temperature_mean, apparent_temperature_mean, sunrise, sunset, rain_sum, wind_speed_max) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    data = (formatted_date, temp_max, temp_min, temp_mean, apparent_temperature_mean, sunrise, sunset, rain_sum,
            wind_speed_max)
    i += 1
    mycursor.execute(sql, data)
    mydb.commit()
