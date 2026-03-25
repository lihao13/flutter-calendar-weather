import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../constants/app_colors';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/weather_card.dart';

class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.currentWeather;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('天气详情'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_city),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CitySelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '加载失败\n${weatherProvider.errorMessage}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => weatherProvider.loadWeather(),
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : weather == null
                  ? const Center(child: Text('暂无天气数据'))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          WeatherCard(
                            weather: weather,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          _buildDetailGrid(weather, isDark),
                          const SizedBox(height: 16),
                          HourlyForecastList(
                            forecasts: weatherProvider.hourlyForecasts,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildDetailGrid(Weather weather, bool isDark) {
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        _buildDetailCard(
          '最低温',
          '${weather.minTemp.round()}°C',
          cardColor,
          textPrimary,
          textSecondary,
        ),
        _buildDetailCard(
          '最高温',
          '${weather.maxTemp.round()}°C',
          cardColor,
          textPrimary,
          textSecondary,
        ),
        _buildDetailCard(
          '体感温度',
          '${weather.feelsLike.round()}°C',
          cardColor,
          textPrimary,
          textSecondary,
        ),
        _buildDetailCard(
          '能见度',
          '${(weather.visibility / 1000).toStringAsFixed(1)} km',
          cardColor,
          textPrimary,
          textSecondary,
        ),
        _buildDetailCard(
          '云量',
          '${weather.clouds}%',
          cardColor,
          textPrimary,
          textSecondary,
        ),
        _buildDetailCard(
          '更新时间',
          '${weather.dateTime.hour}:${weather.dateTime.minute.toString().padLeft(2, '0')}',
          cardColor,
          textPrimary,
          textSecondary,
        ),
      ],
    );
  }

  Widget _buildDetailCard(
    String label,
    String value,
    Color cardColor,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
