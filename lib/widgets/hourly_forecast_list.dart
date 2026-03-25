import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';
import '../constants/app_colors.dart';
import '../utils/weather_utils.dart';

class HourlyForecastList extends StatelessWidget {
  final List<HourlyForecast> forecasts;
  final bool isDark;

  const HourlyForecastList({
    super.key,
    required this.forecasts,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '24小时预报',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: forecasts.length,
              itemBuilder: (context, index) {
                return _buildHourlyItem(forecasts[index], isDark, textPrimary);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(
    HourlyForecast forecast,
    bool isDark,
    Color textColor,
  ) {
    final timeFormat = DateFormat('HH:mm');
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeFormat.format(forecast.time),
            style: TextStyle(
              fontSize: 12,
              color: textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          FaIcon(
            getWeatherIcon(forecast.icon),
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.temperature.round()}°',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
