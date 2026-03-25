import '../models/weather.dart';

class WeatherService {
  Future<Weather> getWeather(City city) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Weather.mock(city: city.name);
  }

  Future<List<HourlyForecast>> getHourlyForecast(City city) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HourlyForecast.mockList();
  }
}
