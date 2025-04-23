import { useState } from "react";

interface WeatherData {
  main: { temp: number };
  weather: { description: string; icon: string }[];
}

function WeatherApp() {
  const [city, setCity] = useState("");
  const [weather, setWeather] = useState<WeatherData | null>(null);
  const [error, setError] = useState("");

  const API_KEY = "e9720fa4e1b4b1242ae658c90b7b8a13"; // замени на свой ключ

  const fetchWeather = async () => {
    try {
      setError("");
      const res = await fetch(
        `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=ru`
      );
      if (!res.ok) throw new Error("Город не найден");
      const data = await res.json();
      setWeather(data);
    } catch (err) {
      setError((err as Error).message);
    }
  };

  return (
    <div>
      <input
        value={city}
        onChange={(e) => setCity(e.target.value)}
        placeholder="Введите город"
      />
      <button onClick={fetchWeather}>Показать погоду</button>
      {error && <p>{error}</p>}
      {weather && (
        <div>
          <p>Температура: {weather.main.temp}°C</p>
          <p>Описание: {weather.weather[0].description}</p>
          <img
            src={`https://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png`}
            alt="icon"
          />
        </div>
      )}
    </div>
  );
}
export default WeatherApp;
