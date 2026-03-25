import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/weather.dart';
import '../providers/calendar_provider.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../constants/app_colors.dart';
import '../widgets/weather_card.dart';
import 'city_selection_screen.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('日历天气'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
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
      body: Column(
        children: [
          Consumer<CalendarProvider>(
            builder: (context, calendarProvider, child) {
              return Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: calendarProvider.focusedDay,
                  calendarFormat: calendarProvider.calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(calendarProvider.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    calendarProvider.setSelectedDay(selectedDay, focusedDay);
                  },
                  onFormatChanged: (format) {
                    calendarProvider.setCalendarFormat(format);
                  },
                  onPageChanged: (focusedDay) {
                    calendarProvider.setFocusedDay(focusedDay);
                  },
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: textPrimary),
                    weekendTextStyle: TextStyle(
                      color: textPrimary.withOpacity(0.6),
                    ),
                    outsideTextStyle: TextStyle(color: textPrimary.withOpacity(0.3)),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: CalendarHeaderStyle(
                    titleTextStyle: TextStyle(
                      color: textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: textPrimary),
                    rightChevronIcon: Icon(Icons.chevron_right, color: textPrimary),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (weatherProvider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '加载失败\n${weatherProvider.errorMessage}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textPrimary),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => weatherProvider.loadWeather(),
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  );
                }

                final weather = weatherProvider.currentWeather;
                if (weather == null) {
                  return const Center(child: Text('暂无天气数据'));
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      WeatherCard(
                        weather: weather,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WeatherDetailScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            '查看详情',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
