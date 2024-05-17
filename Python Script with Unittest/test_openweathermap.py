import unittest
import requests

OPENWEATHERMAP_API_KEY = "6fc77fdf351d2e2cc28564c8b003dd1f"
OPENWEATHERMAP_API_URL = "http://api.openweathermap.org/data/2.5/weather"


class TestOpenWeatherMapAPI(unittest.TestCase):
    def test_api_response(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=metric&appid={api_key}"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 200)
        self.assertIn("London", response.json()["name"])
        self.assertIn("main", response.json())
        self.assertIn("weather", response.json())
    def test_api_response_with_fahrenheit(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=imperial&appid={api_key}"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 200)
        self.assertIn("London", response.json()["name"])
        self.assertIn("main", response.json())
        self.assertIn("weather", response.json())
    def test_invalid_api_key(self):
        api_key = "INVALID_API_KEY"
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=metric&appid={api_key}"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 401)
        self.assertIn("Unauthorized", response.json()["message"])
    def test_invalid_location(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=InvalidLocation&units=metric&appid={api_key}"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 404)
        self.assertIn("city not found", response.json()["message"])
    def test_invalid_units(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=unknown&appid={api_key}"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 400)
        self.assertIn("Invalid units", response.json()["message"])
    def test_invalid_json_response(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=metric&appid={api_key}&format=json"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 200)
        self.assertIn("London", response.json()["name"])
        self.assertIn("main", response.json())
        self.assertIn("weather", response.json())
    def test_max_attempts_reached(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=metric&appid={api_key}&max_attempts=1"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 429)
        self.assertIn("max attempts reached", response.json()["message"])
    def test_ip_address(self):
        api_key = OPENWEATHERMAP_API_KEY
        api_url = f"{OPENWEATHERMAP_API_URL}?q=London&units=metric&appid={api_key}&ip_address=8.8.8.8"
        response = requests.get(api_url)
        self.assertEqual(response.status_code, 200)
        self.assertIn("London", response.json()["name"])
        self.assertIn("main", response.json())
        self.assertIn("weather", response.json())



if __name__ == "__main__":
    unittest.main()