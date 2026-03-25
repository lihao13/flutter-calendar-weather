import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;

  WeatherProvider(this._weatherService);

  Weather? _currentWeather;
  List<HourlyForecast> _hourlyForecasts = [];
  List<City> _availableCities = [];
  City? _selectedCity;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get currentWeather => _currentWeather;
  List<HourlyForecast> get hourlyForecasts => _hourlyForecasts;
  List<City> get availableCities => _availableCities;
  City? get selectedCity => _selectedCity;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    _availableCities = City.mockList();
    if (_availableCities.isNotEmpty) {
      _selectedCity = _availableCities.first;
      await loadWeather();
    }
  }

  Future<void> loadWeather() async {
    if (_selectedCity == null) return;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getWeather(_selectedCity!);
      _hourlyForecasts = await _weatherService.getHourlyForecast(_selectedCity!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCity(City city) {
    _selectedCity = city;
    loadWeather();
  }

  List<City> searchCities(String query) {
    if (query.isEmpty) return _availableCities;
    return _availableCities
        .where((city) =>
            city.name.toLowerCase().contains(query.toLowerCase()) ||
            city.country.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
