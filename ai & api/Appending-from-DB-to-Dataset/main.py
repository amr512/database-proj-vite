import requests
import mysql.connector
mydb = mysql.connector.connect(
    user='USER',
    password='PASSWORD',
    host='127.0.0.1',
    database='weather_forecast'
)
mycursor = mydb.cursor()
cities_name = ["cairo","alex","aswan","sharm","zagazig"]
for city in cities_name:
    mycursor.execute(f"SELECT * FROM {city}")
    my_result = mycursor.fetchall()
    dates = []
    location_id = []
    temperature_max = []
    temperature_min = []
    temperature_mean = []
    rain_sum = []
    wind_speed_max = []

    for row in my_result:
        datetime_value = row[1]  # Assuming the date is in the second column (index 1)
        formatted_date = datetime_value.strftime('%m/%d/%Y')  # Format date as 'YYYY-MM-DD'
        dates.append(formatted_date)
        id_l = row[0]
        location_id.append(id_l)
        temp_max = row[2]
        temperature_max.append(temp_max)
        temp_min = row[3]
        temperature_min.append(temp_min)
        temp_mean = row[4]
        temperature_mean.append(temp_mean)
        rain = row[8]
        rain_sum.append(rain)
        wind = row[9]
        wind_speed_max.append(wind)
    for i in range(len(wind_speed_max)):
        body = {
            'weatherDatasetCsv': {
                "locationId": location_id[i],
                "date": dates[i],
                "temperatureMax": temperature_max[i],
                "temperatureMin": temperature_min[i],
                "temperatureMean": temperature_mean[i],
                "rainSum": rain_sum[i],
                "windSpeedMax": wind_speed_max[i]
            }
        }
        SHEETY_ENDPOINT = "https://api.sheety.co/url"
        SHEETY_HEADERS = {
            'Content-Type': "application/json",
            'Authorization': ''
        }
        sheety_post = requests.post(SHEETY_ENDPOINT, json=body, headers=SHEETY_HEADERS)
        print(sheety_post.text)
