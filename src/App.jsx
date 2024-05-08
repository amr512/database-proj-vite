import { useContext, useEffect, useMemo, useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './style.css'

const API_KEY = "2e4da4cd15ebf162ad3ae699a4abcd85"; // API key for OpenWeatherMap API

const supportedCities = ["cairo", "alex", "aswan", "sharm", "zagazig"]
//انا اسف لأي حد بيحاول يقرا الكود
//نص الكود مش شغال ف حاول تتفاداه


const createWeatherCard = (type,weatherItem, index) => {
    if(type === "predictive"){
        if (index === 0){
                return (
                <>
                <div className="current-weather">
                <div className="details" key={index}>
                <h2>{weatherItem.city} ({weatherItem.date})</h2>
                <h6>Max Temperature: {weatherItem.max_temp}°C</h6>
                <h6>Max Temperature: {weatherItem.min_temp}°C</h6>
                <h6>Wind: *placeholder* M/S</h6>
                <h6>Humidity: *placeholder* %</h6>
                <h6>*placeholder*</h6>
                </div>
            <div className="icon">
                <img src={`https://openweathermap.org/img/wn/${/*weatherItem.weather[0].icon*/"10d"}@4x.png`} alt="weather-icon"/>
            </div>
            </div>
            </>);
        } else {
            return (
            <>
            <li className="card" key={index}>
            <h3>({weatherItem.date})</h3>
            <img src={`https://openweathermap.org/img/wn/${/*weatherItem.weather[0].icon*/"10d"}@4x.png`} alt="weather-icon"/>
            <h6>Max Temperature: {weatherItem.max_temp}°C</h6>
            <h6>Max Temperature: {weatherItem.min_temp}°C</h6>
            <h6>Wind: placeholder M/S</h6>
            <h6>Humidity: *placeholder* %</h6>
        </li>
        </>);
        }
    }
    // won't work pls don't go here
    if (index === 0) { // HTML for the main weather card
        return `<div class="details">
                    <h2>${cityName} (${weatherItem.dt_txt.split(" ")[0]})</h2>
                    <h6>Temperature: ${/*(max_temp).toFixed(2)*/"oaaoe"}°C</h6>
                    <h6>Wind: ${weatherItem.wind.speed} M/S</h6>
                    <h6>Humidity: ${weatherItem.main.humidity}%</h6>
                </div>
                <div class="icon">
                    <img src="https://openweathermap.org/img/wn/${weatherItem.weather[0].icon}@4x.png" alt="weather-icon">
                    <h6>${weatherItem.weather[0].description}</h6>
                </div>`;
    } else { // HTML for the other five day forecast card
        return `<li class="card">
                    <h3>(${weatherItem.dt_txt.split(" ")[0]})</h3>
                    <img src="https://openweathermap.org/img/wn/${weatherItem.weather[0].icon}@4x.png" alt="weather-icon">
                    <h6>Temp: ${(weatherItem.main.temp - 273.15).toFixed(2)}°C</h6>
                    <h6>Wind: ${weatherItem.wind.speed} M/S</h6>
                    <h6>Humidity: ${weatherItem.main.humidity}%</h6>
                </li>`;
    }
}

const getCityCoordinates = async (cityName, date = new Date().toISOString().split("T")[0]) => {
    try {
        if (supportedCities.includes(cityName.toLowerCase())) {
            console.log(cityName, date)
            return [cityName, { date: date }]
        } else {
            const API_URL = `https://api.openweathermap.org/geo/1.0/direct?q=${cityName}&limit=1&appid=${API_KEY}`;
            
            // Get entered city coordinates (latitude, longitude, and name) from the API response
            const data = await (await fetch(API_URL)).json()
            if (!data.length) return alert(`No coordinates found for ${cityName}`);
            const { lat, lon, name } = data[0];
            console.log(cityName, lat,lon)
            return [name, { lat: lat, lon: lon }];
        }
    } catch {
        (err) => {
            alert("An error occurred while fetching the coordinates! " + err.toString());
        };
    }
}

// not tested
const getUserCoordinates = () => {
    navigator.geolocation.getCurrentPosition(
        position => {
            const { latitude, longitude } = position.coords; // Get coordinates of user location
            // Get city name from coordinates using reverse geocoding API
            const API_URL = `https://api.openweathermap.org/geo/1.0/reverse?lat=${latitude}&lon=${longitude}&limit=1&appid=${API_KEY}`;
            fetch(API_URL).then(response => response.json()).then(data => {
                const { name } = data[0];
                getWeatherDetails(name, latitude, longitude);
            }).catch(() => {
                alert("An error occurred while fetching the city name!");
            });
        },
        error => { // Show alert if user denied the location permission
            if (error.code === error.PERMISSION_DENIED) {
                alert("Geolocation request denied. Please reset location permission to grant access again.");
            } else {
                alert("Geolocation request error. Please reset location permission.");
            }
        });
}
const getWeatherDetails = async (data_) => {
    console.log(data_)
    const cityName = data_[0];
    const info = data_[1];
    try {
        if (info.date !== undefined) {
            const data = await (await fetch(`http://localhost:5000/?city=${cityName}&date=${info.date}`,{method:"GET"})).json();
            console.log(data)
            return {type:"predictive",data:data};
        }
        else {
            const { lat, lon } = info;
            const WEATHER_API_URL = `http://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${API_KEY}`;
            const data = await ((await fetch(WEATHER_API_URL)).json());
            console.log(data)
            // Filter the forecasts to get only one forecast per day
            const uniqueForecastDays = [];
            const fiveDaysForecast = data.list.filter(forecast => {
                const forecastDate = new Date(forecast.dt_txt).getDate();
                if (!uniqueForecastDays.includes(forecastDate)) {
                    forecast.main.temp_max = (forecast.main.temp_max - 273.15).toFixed(2);
                    forecast.main.temp_min = (forecast.main.temp_min - 273.15).toFixed(2);
                    return uniqueForecastDays.push(forecastDate);
                }
            });

            // Clearing previous weather data
            // cityInput.value = "";
            // currentWeatherDiv.innerHTML = "";
            // weatherCardsDiv.innerHTML = "";

            // Creating weather cards and adding them to the DOM
            return {type:"api",data:fiveDaysForecast}
        }
    } catch {
        (err) => {
            alert("An error occurred while fetching the weather forecast!" + err.toString());
        }
    };
}
    


function App() {
    const [cityName, setCityName] = useState("cairo")
    const [cityInfo, setCityInfo] = useState({})
    const [weatherData, setWeatherData] = useState({})
    const [date, setDate] = useState(new Date().toISOString().split("T")[0])
    const [firstLoad, setFirstLoad] = useState(true)

    if(firstLoad){
        setFirstLoad(false)
        getCityCoordinates(cityName, date)
        .then(data => getWeatherDetails(data)
        .then(data2 => setWeatherData(data2)))
    }


    return (
        <>
            <h1>weather Dashboard</h1>
            <div className="container">
                {/*<video src="./background-video/Sun Burst Between Erie Clouds Time Lapse - Royalty Free HD Stock Video Footage..mp4" loop muted autoPlay  />*/}
                <div className="weather-input">
                    <h3>Enter a City Name</h3>
                    <input className="city-input" 
                    onChange={e => setCityName(e.target.value)}
                    onKeyUp={e => {if(e.key === "Enter") {
                        setRefresh1(true)
                        }}
                    } type="text" placeholder="E.G., Cairo, Alexandria, " />
                    <input className="date-input" onChange={e=> setDate(e.target.value)} type="date" />
                    <button className="search-btn" onClick={e=>getCityCoordinates(cityName, date)
        .then(data => getWeatherDetails(data)
        .then(data2 => setWeatherData(data2)))}>Search</button>
                    <div className="separator"></div>
                    <button className="location-btn" onClick={getUserCoordinates}>Use Current Location</button>
                </div>

                <div className="weather-data">
                    <div className="weather-cards">
                    {weatherData? weatherData.data?.map((weatherItem, index) => createWeatherCard(weatherData.type,weatherData.data[index], index))
                    :
                    //add loading spinner eventually 
                    "loading"}
                    </div>
                    {/* <div className="current-weather">
                        <div className="details">
                            <h2> Cairo (2024-5-6)</h2>
                            <h4 id="temp">Temperature: </h4>
                            <h4>Wind: 16.7km/h</h4>
                            <h4>Humidity: 60%</h4>
                        </div>
                        <div className="icon">
                            <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                            <h4>Moderate Rain</h4>
                        </div>
                    </div>
                    <div className="day-forecast">
                        <h2>5-Days Forecast</h2>
                        <ul className="weather-cards">
                            <li className="card">
                                <h3> Cairo (2024-4-16)</h3>
                                <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                                <h4>Temp: 25°C</h4>
                                <h4>Wind: 16.7km/h</h4>
                                <h4>Humidity: 60%</h4>
                            </li>
                            <li className="card">
                                <h3> Cairo (2024-4-16)</h3>
                                <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                                <h4>Temp: 25°C</h4>
                                <h4>Wind: 16.7km/h</h4>
                                <h4>Humidity: 60%</h4>
                            </li>
                            <li className="card">
                                <h3> Cairo (2024-4-16)</h3>
                                <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                                <h4>Temp: 25°C</h4>
                                <h4>Wind: 16.7km/h</h4>
                                <h4>Humidity: 60%</h4>
                            </li>
                            <li className="card">
                                <h3> Cairo (2024-4-16)</h3>
                                <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                                <h4>Temp: 25°C</h4>
                                <h4>Wind: 16.7km/h</h4>
                                <h4>Humidity: 60%</h4>
                            </li>
                            <li className="card">
                                <h3> Cairo (2024-4-16)</h3>
                                <img src="https://openweathermap.org/img/wn/10d@4x.png" alt="weather-icon" />
                                <h4>Temp: 25°C</h4>
                                <h4>Wind: 16.7km/h</h4>
                                <h4>Humidity: 60%</h4>
                            </li>
                        </ul>
                    </div> */}
                </div>
            </div>
        </>
    )
}

export default App
