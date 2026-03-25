class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String description;
  final String icon;
  final int visibility;
  final int clouds;
  final DateTime dateTime;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.description,
    required this.icon,
    required this.visibility,
    required this.clouds,
    required this.dateTime,
  });

  factory Weather.mock({String city = '北京', DateTime? date}) {
    return Weather(
      cityName: city,
      temperature: 22.5,
      feelsLike: 21.0,
      minTemp: 18.0,
      maxTemp: 26.0,
      humidity: 65,
      windSpeed: 3.5,
      pressure: 1013,
      description: '晴朗',
      icon: '01d',
      visibility: 10000,
      clouds: 10,
      dateTime: date ?? DateTime.now(),
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String icon;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.icon,
  });

  static List<HourlyForecast> mockList() {
    final now = DateTime.now();
    return List.generate(24, (index) {
      final time = now.add(Duration(hours: index));
      return HourlyForecast(
        time: time,
        temperature: 18 + (index % 8) * 1.5,
        icon: index < 6 || index > 18 ? '01n' : '01d',
      );
    });
  }
}

class City {
  final String name;
  final String country;
  final double lat;
  final double lon;

  City({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  static List<City> mockList() {
    return [
      City(name: '北京', country: 'CN', lat: 39.9042, lon: 116.4074),
      City(name: '上海', country: 'CN', lat: 31.2304, lon: 121.4737),
      City(name: '广州', country: 'CN', lat: 23.1291, lon: 113.2644),
      City(name: '深圳', country: 'CN', lat: 22.5431, lon: 114.0579),
      City(name: '杭州', country: 'CN', lat: 30.2741, lon: 120.1551),
      City(name: '成都', country: 'CN', lat: 30.5728, lon: 104.0668),
      City(name: 'Tokyo', country: 'JP', lat: 35.6762, lon: 139.6503),
      City(name: 'New York', country: 'US', lat: 40.7128, lon: -74.0060),
    ];
  }
}
