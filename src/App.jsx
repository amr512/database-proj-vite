import { useContext, useEffect, useMemo, useState } from 'react'

import './style.css'

const API_KEY = "2e4da4cd15ebf162ad3ae699a4abcd85"; // API key for OpenWeatherMap API

const supportedCities = ["cairo", "alex", "aswan", "sharm", "zagazig"]


const createMainWeatherCard = (type, weatherItem) => {
    if (type === "predictive") {
        return (
            <>
                <div className="current-weather">
                    <div className="details">
                        <h2>{weatherItem.city} ({weatherItem.date})</h2>
                        <h6>Temperature: {weatherItem.mean_temp}°C</h6>
                        <h6>Predicted Max: {weatherItem.max_temp}°C</h6>
                        <h6>Predicted Min: {weatherItem.min_temp}°C</h6>
                        <h6>Wind:{weatherItem.wind_speed} M/S</h6>
                        <h6>Rain chance: {Number(weatherItem.rain_chance) * 100}%</h6>
                        {/* <h6>*placeholder*</h6> */}
                    </div>
                </div>
            </>);
    } else {
        return (
            <>
                <div className="current-weather">
                    <div className="details">
                        <h2>{weatherItem.city} ({weatherItem.dt_txt.split(" ")[0]})</h2>
                        <h6>Temperature: {(weatherItem.main.temp - 273.15).toFixed(2)}°C</h6>
                        <h6>Predicted Max: {weatherItem.main.temp_max}°C</h6>
                        <h6>Predicted Min: {weatherItem.main.temp_min}°C</h6>
                        <h6>Wind:{weatherItem.wind.speed} M/S</h6>
                        <h6>Rain volume: {weatherItem.rain?.["1h"] || weatherItem.rain?.["3h"] || "none"} mm</h6>
                        {/* <h6>*placeholder*</h6> */}
                    </div>
                    <div className="icon">
                        <img src={`https://openweathermap.org/img/wn/${weatherItem.weather[0].icon}@4x.png`} alt="weather-icon" />
                    </div>
                </div>
            </>);
    }
}

const createWeatherCards = (type, weatherItem, index) => {
    if (index === 0) return;
    if (type === "predictive") {
        return (
            <li className="card" key={index}>
                <h3>({weatherItem.date})</h3>
                <h6>Predicted Temperature: {weatherItem.mean_temp}°C</h6>
                <h6>Predicted Max: {weatherItem.max_temp}°C</h6>
                <h6>Predicted Min: {weatherItem.min_temp}°C</h6>
                <h6>Wind: {weatherItem.wind_speed} M/S</h6>
                <h6>Rain chance: {Number(weatherItem.rain_chance) * 100}%</h6>
            </li>
        );
    } else { // HTML for the other five day forecast card
        return (
            <li className="card" key={index}>
                <h3>({weatherItem.dt_txt.split(" ")[0]})</h3>
                <img src={`https://openweathermap.org/img/wn/${weatherItem.weather[0].icon}@4x.png`} alt="weather-icon" />
                <h6>Temperature: {(weatherItem.main.temp - 273.15).toFixed(2)}°C</h6>
                <h6>Predicted Max: {weatherItem.main.temp_max}°C</h6>
                <h6>Predicted Min: {weatherItem.main.temp_min}°C</h6>
                <h6>Wind: {weatherItem.wind.speed} M/S</h6>
                <h6>Rain volume: {weatherItem.rain?.["1h"] || "none"} mm</h6>
            </li>
        );
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
            console.log(cityName, lat, lon)
            return [name, { lat: lat, lon: lon }];
        }
    } catch {
        (err) => {
            alert("An error occurred while fetching the coordinates! " + err.toString());
        };
    }
}


const getPosition = async () => {
    return new Promise((resolve, reject) => {
        navigator.geolocation.getCurrentPosition(p => resolve(p.coords), reject);
    })
}

const getUserCoordinates = async () => {
    try {
        const { latitude, longitude } = await getPosition()
        console.log(latitude, longitude)
        // Get city name from coordinates using reverse geocoding API
        const API_URL = `https://api.openweathermap.org/geo/1.0/reverse?lat=${latitude}&lon=${longitude}&limit=1&appid=${API_KEY}`;
        const data = await (await fetch(API_URL)).json().catch(() => {
            alert("An error occurred while fetching the city name!");
        });
        console.log(data);
        return [data[0].name, { lat: latitude, lon: longitude }];
    } catch {
        err => {
            if (err.code === err.PERMISSION_DENIED) {
                alert("Geolocation request denied. Please reset location permission to grant access again.");
            } else {
                alert("Geolocation request error. Please reset location permission.");
            }
        }
    }
}
const getWeatherDetails = async (data_) => {
    console.log(data_)
    const cityName = data_[0];
    const info = data_[1];
    try {
        if (info.date !== undefined) {
            const predictionServerURL = "http://localhost:5000"//import.meta.env.DEV ? "http://localhost:5000" : "https://python-weather-server-1.onrender.com"
            const data = await (await fetch(`${predictionServerURL}/?city=${cityName}&date=${info.date}`, { method: "GET" })).json();
            console.log(data)
            return { type: "predictive", data: data };
        }
        else {
            const { lat, lon } = info;
            const WEATHER_API_URL = `http://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${API_KEY}`;
            const data = await ((await fetch(WEATHER_API_URL)).json());
            console.log(data)
            // Filter the forecasts to get only one forecast per day
            const uniqueForecastDays = [];
            const fiveDaysForecast = data.list.filter(forecast => {
                forecast.main.temp_max = (forecast.main.temp_max - 273.15).toFixed(2);
                forecast.main.temp_min = (forecast.main.temp_min - 273.15).toFixed(2);
                forecast.city = cityName;
                const forecastDate = new Date(forecast.dt_txt).getDate();
                if (!uniqueForecastDays.includes(forecastDate)) {
                    return uniqueForecastDays.push(forecastDate);
                }
            });

            // Clearing previous weather data
            // cityInput.value = "";
            // currentWeatherDiv.innerHTML = "";
            // weatherCardsDiv.innerHTML = "";
            // Creating weather cards and adding them to the DOM
            return { type: "api", data: fiveDaysForecast }
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
    const [weatherData, setWeatherData] = useState()
    const [date, setDate] = useState(new Date().toISOString().split("T")[0])
    const [firstLoad, setFirstLoad] = useState(true)
    const [dateDisabled, setDateDisabled] = useState(false)
    if (firstLoad) {
        setFirstLoad(false)
        updateWeather()
    }

    function updateWeather() {
        if (cityName === "") {
            alert("Please enter a city name!");
            return;
        }
        getCityCoordinates(cityName, date)
            .then(data => getWeatherDetails(data)
                .then(data2 => setWeatherData(data2)))
    }

    useEffect(() => {
        if (!supportedCities.includes(cityName.toLowerCase())) {

            setDateDisabled(true);
        } else {
            setDateDisabled(false);
        }
    }, [cityName])

    return (
        <>
            <h1>weather Dashboard</h1>
            <div className="container">
                <div className="weather-input">
                    <video src="./background-video/Sun Burst Between Erie Clouds Time Lapse - Royalty Free HD Stock Video Footage..mp4" loop muted autoPlay />
                    <h3>Enter a City Name</h3>
                    <input className="city-input"
                        onChange={e => setCityName(e.target.value)}
                        onKeyUp={e => {
                            if (e.key === "Enter") {
                                updateWeather()
                            }
                        }
                        } type="text" placeholder="E.G., Cairo, Alexandria, " />
                    <input
                        disabled={dateDisabled}
                        onKeyUp={e => {
                            if (e.key === "Enter") {
                                updateWeather()
                            }
                        }
                        }
                        className="date-input" onChange={e => setDate(e.target.value)} type="date" />
                    <button className="search-btn" onClick={updateWeather}>Search</button>
                    <div className="separator"></div>
                    <button className="location-btn" onClick={e => getUserCoordinates().then(data => getWeatherDetails(data).then(data2 => setWeatherData(data2)))}>Use Current Location</button>
                </div>

                <div className="weather-data">
                    <div className="current-weather">
                        {weatherData ? createMainWeatherCard(weatherData.type, weatherData.data[0]) : "loading"}
                        <div className="day-forecast">
                            <h2>5-Days Forecast</h2>
                            <ul className="weather-cards">
                                {weatherData ? weatherData.data?.map((weatherItem, index) => createWeatherCards(weatherData.type, weatherData.data[index], index))
                                    :
                                    //add loading spinner eventually 
                                    "loading"}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            {/* </video> */}
        </>
    )
}

export default App
