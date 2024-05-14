import pickle
import pandas as pd
from sklearn import linear_model
from datetime import date, timedelta
import flask as fl
from flask_cors import CORS

app = fl.Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/', methods=['GET', 'POST'])
def home():
    if fl.request.method == 'GET' or fl.request.method == 'OPTIONS':
        response = fl.make_response(predict_next_5_days(fl.request.args.get('city').lower(), fl.request.args.get('date')))
        return response
    else:
        return "404 Not Found"



def predict_weather(city, desires_date):
    if(date.today().isoformat() == desires_date):
        today_date = date.fromisoformat(desires_date) + timedelta(days=-1)
    else:
        today_date = date.today()
    predicted_max = 0
    predicted_min = 0
    predicted_wind = 0
    predicted_mean = 0
    predicted_rain = 0
    

    date_ = [today_date, desires_date]

    future = pd.DataFrame()
    future['ds'] = pd.to_datetime(date_)
    future['y'] = None

    if city == "cairo":
        # max
        linear = linear_model.LinearRegression()
        pickle_file = open("cairo_max_temp_model.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)
        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open("cairo_min_temp.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)
        # mean
        linear2 = linear_model.LinearRegression()
        pickle_mean = open("cairo_mean_temp_predictor_model.pkl", "rb")
        linear2 = pickle.load(pickle_mean)
        linear2.restore_trainer()
        prediction_mean = linear2.predict(future)
        predicted_mean = round(float(prediction_mean['yhat1'][1]), 2)
        # rain
        linear3 = linear_model.LinearRegression()
        pickle_rain = open("cairo_rain.pkl", "rb")
        linear3 = pickle.load(pickle_rain)
        linear3.restore_trainer()
        prediction_rain = linear3.predict(future)
        predicted_rain = round(float(prediction_rain['yhat1'][1]), 2)
        if predicted_rain < 0:
            predicted_rain = 0
        # wind_speed_max
        linear4 = linear_model.LinearRegression()
        pickle_wind = open("cairo_max_wind_speed.pkl", "rb")
        linear4 = pickle.load(pickle_wind)
        linear4.restore_trainer()
        prediction_wind = linear4.predict(future)
        predicted_wind = round(float(prediction_wind['yhat1'][1]), 2)


    elif city == "alex":
        linear = linear_model.LinearRegression()
        pickle_file = open("alex_temperature_max.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)

        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open("alex_temperature_min.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)
        # mean
        linear2 = linear_model.LinearRegression()
        pickle_mean = open("alex_mean_temp.pkl", "rb")
        linear2 = pickle.load(pickle_mean)
        linear2.restore_trainer()
        prediction_mean = linear2.predict(future)
        predicted_mean = round(float(prediction_mean['yhat1'][1]), 2)
        # rain
        linear3 = linear_model.LinearRegression()
        pickle_rain = open("alex_rain.pkl", "rb")
        linear3 = pickle.load(pickle_rain)
        linear3.restore_trainer()
        prediction_rain = linear3.predict(future)
        predicted_rain = round(float(prediction_rain['yhat1'][1]), 2)
        if predicted_rain < 0:
            predicted_rain = 0
        # wind_speed_max
        linear4 = linear_model.LinearRegression()
        pickle_wind = open("alex_wind_max.pkl", "rb")
        linear4 = pickle.load(pickle_wind)
        linear4.restore_trainer()
        prediction_wind = linear4.predict(future)
        predicted_wind = round(float(prediction_wind['yhat1'][1]), 2)

    elif city == "aswan":
        linear = linear_model.LinearRegression()
        pickle_file = open("aswan_temp_max.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)

        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open("aswan_temp_min.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)
        # mean
        linear2 = linear_model.LinearRegression()
        pickle_mean = open("aswan_mean.pkl", "rb")
        linear2 = pickle.load(pickle_mean)
        linear2.restore_trainer()
        prediction_mean = linear2.predict(future)
        predicted_mean = round(float(prediction_mean['yhat1'][1]), 2)
        # rain
        linear3 = linear_model.LinearRegression()
        pickle_rain = open("aswan_rain.pkl", "rb")
        linear3 = pickle.load(pickle_rain)
        linear3.restore_trainer()
        prediction_rain = linear3.predict(future)
        predicted_rain = round(float(prediction_rain['yhat1'][1]), 2)
        if predicted_rain < 0:
            predicted_rain = 0
        # wind_speed_max
        linear4 = linear_model.LinearRegression()
        pickle_wind = open("aswan_wind_max.pkl", "rb")
        linear4 = pickle.load(pickle_wind)
        linear4.restore_trainer()
        prediction_wind = linear4.predict(future)
        predicted_wind = round(float(prediction_wind['yhat1'][1]), 2)

    elif city == "sharm":
        linear = linear_model.LinearRegression()
        pickle_file = open("sharm_max_temp.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)

        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open("sharm_min_temp.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)
        # mean
        linear2 = linear_model.LinearRegression()
        pickle_mean = open("sharm_mean.pkl", "rb")
        linear2 = pickle.load(pickle_mean)
        linear2.restore_trainer()
        prediction_mean = linear2.predict(future)
        predicted_mean = round(float(prediction_mean['yhat1'][1]), 2)
        # rain
        linear3 = linear_model.LinearRegression()
        pickle_rain = open("sharm_rain.pkl", "rb")
        linear3 = pickle.load(pickle_rain)
        linear3.restore_trainer()
        prediction_rain = linear3.predict(future)
        predicted_rain = round(float(prediction_rain['yhat1'][1]), 2)
        if predicted_rain < 0:
            predicted_rain = 0
            # wind_speed_max
        linear4 = linear_model.LinearRegression()
        pickle_wind = open("sharm_max_wind.pkl", "rb")
        linear4 = pickle.load(pickle_wind)
        linear4.restore_trainer()
        prediction_wind = linear4.predict(future)
        predicted_wind = round(float(prediction_wind['yhat1'][1]), 2)

    elif city == "zagazig":
        linear = linear_model.LinearRegression()
        pickle_file = open("zag_max_temp.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)

        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open("zag_min_temp.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)
        # mean
        linear2 = linear_model.LinearRegression()
        pickle_mean = open("zag_mean_temp.pkl", "rb")
        linear2 = pickle.load(pickle_mean)
        linear2.restore_trainer()
        prediction_mean = linear2.predict(future)
        predicted_mean = round(float(prediction_mean['yhat1'][1]), 2)
        # rain
        linear3 = linear_model.LinearRegression()
        pickle_rain = open("zag_rain.pkl", "rb")
        linear3 = pickle.load(pickle_rain)
        linear3.restore_trainer()
        prediction_rain = linear3.predict(future)
        predicted_rain = round(float(prediction_rain['yhat1'][1]), 2)
        if predicted_rain < 0:
            predicted_rain = 0
            # wind_speed_max
        linear4 = linear_model.LinearRegression()
        pickle_wind = open("zag_wind.pkl", "rb")
        linear4 = pickle.load(pickle_wind)
        linear4.restore_trainer()
        prediction_wind = linear4.predict(future)
        predicted_wind = round(float(prediction_wind['yhat1'][1]), 2)
    else:
        return "please make sure you entered the date & the city name correctly."

    # display = (f"in {desires_date}\nmax temp probably will be: {predicted_max} °C\nmin temp probably will be:  {predicted_min}°C\n"
    #            f"mean temp probably will be: {predicted_mean}"
    #            f"\nrain sum may be around: {predicted_rain}\nmax wind speed: {predicted_wind}")
    display = {
            "city": city,
            "date": desires_date, 
            "max_temp": predicted_max, 
            "min_temp": predicted_min, 
            "mean_temp": predicted_mean, 
            "rain_chance": predicted_rain, 
            "wind_speed": predicted_wind}
    return display

def predict_next_5_days(city,desires_date):
    predictions = []
    for i in range(6):
        predictions.append(predict_weather(city, desires_date))
        desires_date = (date.fromisoformat(desires_date) + timedelta(days=1)).isoformat()
    return predictions