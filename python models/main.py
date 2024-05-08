import pickle
import pandas as pd
from sklearn import linear_model
from datetime import date, datetime, timedelta
import flask as fl
from flask_cors import CORS

app = fl.Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/', methods=['GET', 'POST'])
def home():
    if fl.request.method == 'GET' or fl.request.method == 'OPTIONS':
        response = fl.make_response(get_temp_next_5_days(fl.request.args.get('city').lower(), fl.request.args.get('date')))
        return response
    else:
        return "404 Not Found"


def get_temp(city, desires_date):
    # # i fucking hate programming 
    # fuck = desires_date.split('-')
    # desired = fuck[0]+str(int(fuck[1]))+str(int(fuck[2]))
    if(date.today().isoformat() == desires_date):
        today_date = date.fromisoformat(desires_date) + timedelta(days=-1)
    else:
        today_date = date.today()
    predicted_max = 0
    predicted_min = 0
    date_ = [today_date, desires_date]
    future = pd.DataFrame()
    try:
        future['ds'] = pd.to_datetime(date_)
    except:
        return "invalid date format"
    future['y'] = None
    supported_cities = ["cairo", "alex", "aswan", "sharm", "zagazig"]
    
    if city not in supported_cities:
        return "invalid city"
    else: 
        linear = linear_model.LinearRegression()
        pickle_file = open(f"{city}_max.pkl", "rb")
        linear = pickle.load(pickle_file)
        linear.restore_trainer()
        predictions = linear.predict(future)
        predicted_max = round(float(predictions['yhat1'][1]), 2)

        # Min
        linear1 = linear_model.LinearRegression()
        pickle_min = open(f"{city}_min.pkl", "rb")
        linear1 = pickle.load(pickle_min)
        linear1.restore_trainer()
        prediction_min = linear1.predict(future)
        predicted_min = round(float(prediction_min['yhat1'][1]), 2)

    # if city == "cairo":
    #     linear = linear_model.LinearRegression()
    #     pickle_file = open("cairo_max_temp_model.pkl", "rb")
    #     linear = pickle.load(pickle_file)
    #     linear.restore_trainer()
    #     predictions = linear.predict(future)
    #     predicted_max = round(float(predictions['yhat1'][1]), 2)

    #     # Min
    #     linear1 = linear_model.LinearRegression()
    #     pickle_min = open("cairo_min_temp.pkl", "rb")
    #     linear1 = pickle.load(pickle_min)
    #     linear1.restore_trainer()
    #     prediction_min = linear1.predict(future)
    #     predicted_min = round(float(prediction_min['yhat1'][1]), 2)

    # elif city == "alex":
    #     linear = linear_model.LinearRegression()
    #     pickle_file = open("alex_temperature_max.pkl", "rb")
    #     linear = pickle.load(pickle_file)
    #     linear.restore_trainer()
    #     predictions = linear.predict(future)
    #     predicted_max = round(float(predictions['yhat1'][1]), 2)

    #     # Min
    #     linear1 = linear_model.LinearRegression()
    #     pickle_min = open("alex_temperature_min.pkl", "rb")
    #     linear1 = pickle.load(pickle_min)
    #     linear1.restore_trainer()
    #     prediction_min = linear1.predict(future)
    #     predicted_min = round(float(prediction_min['yhat1'][1]), 2)

    # elif city == "aswan":
    #     linear = linear_model.LinearRegression()
    #     pickle_file = open("aswan_temp_max.pkl", "rb")
    #     linear = pickle.load(pickle_file)
    #     linear.restore_trainer()
    #     predictions = linear.predict(future)
    #     predicted_max = round(float(predictions['yhat1'][1]), 2)

    #     # Min
    #     linear1 = linear_model.LinearRegression()
    #     pickle_min = open("aswan_temp_min.pkl", "rb")
    #     linear1 = pickle.load(pickle_min)
    #     linear1.restore_trainer()
    #     prediction_min = linear1.predict(future)
    #     predicted_min = round(float(prediction_min['yhat1'][1]), 2)

    # elif city == "sharm":
    #     linear = linear_model.LinearRegression()
    #     pickle_file = open("sharm_max_temp.pkl", "rb")
    #     linear = pickle.load(pickle_file)
    #     linear.restore_trainer()
    #     predictions = linear.predict(future)
    #     predicted_max = round(float(predictions['yhat1'][1]), 2)

    #     # Min
    #     linear1 = linear_model.LinearRegression()
    #     pickle_min = open("sharm_min_temp.pkl", "rb")
    #     linear1 = pickle.load(pickle_min)
    #     linear1.restore_trainer()
    #     prediction_min = linear1.predict(future)
    #     predicted_min = round(float(prediction_min['yhat1'][1]), 2)

    # elif city == "zagazig":
    #     linear = linear_model.LinearRegression()
    #     pickle_file = open("zag_max_temp.pkl", "rb")
    #     linear = pickle.load(pickle_file)
    #     linear.restore_trainer()
    #     predictions = linear.predict(future)
    #     predicted_max = round(float(predictions['yhat1'][1]), 2)

    #     # Min
    #     linear1 = linear_model.LinearRegression()
    #     pickle_min = open("zag_min_temp.pkl", "rb")
    #     linear1 = pickle.load(pickle_min)
    #     linear1.restore_trainer()
    #     prediction_min = linear1.predict(future)
    #     predicted_min = round(float(prediction_min['yhat1'][1]), 2)
    # else:
    #     print("please make sure you entered the date & the city name correctly.")
    display = {"city": city, "date": desires_date, "max_temp": predicted_max, "min_temp": predicted_min}
    # response = fl.make_response(display)
    # response.headers["Access-Control-Allow-Origin"] = "*"
    # response.headers["Content-Type"] = "application/json"
    # response.headers["x-content-type-options"] = "nosniff"
    return(display)

def get_temp_next_5_days(city,desires_date):
    temps = []
    for i in range(6):
        temps.append(get_temp(city, desires_date))
        desires_date = (date.fromisoformat(desires_date) + timedelta(days=1)).isoformat()
    return temps