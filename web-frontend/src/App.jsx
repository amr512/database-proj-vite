import { useEffect, useState } from 'react'

import './style.css'
import { getCityCoordinates, getWeatherDetails, supportedCities, getUserCoordinates, createMainWeatherCard, createWeatherCards } from './utils.jsx';

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

            <video src="/background-video/3.mp4" loop muted autoPlay />
            <h1>WeatherEase</h1>
            <div className="container">
                <div className="weather-input">
                    <h4>Enter a City Name</h4>
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
                        <div className="day-forecast">
                            {weatherData ? createMainWeatherCard(weatherData.type, weatherData.data[0]) : "loading"}

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
