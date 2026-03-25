import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/weather.dart';
import 'providers/theme_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/calendar_provider.dart';
import 'services/weather_service.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider(WeatherService())),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ],
      child: const AppInitializer(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Provider.of<ThemeProvider>(context, listen: false).init();
    await Provider.of<WeatherProvider>(context, listen: false).init();
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        ThemeData themeData;
        switch (themeProvider.themeMode) {
          case ThemeMode.light:
            themeData = AppTheme.getLightTheme();
            break;
          case ThemeMode.dark:
            themeData = AppTheme.getDarkTheme();
            break;
          case ThemeMode.system:
          default:
            final brightness = WidgetsBinding.instance.window.platformBrightness;
            themeData = brightness == Brightness.dark
                ? AppTheme.getDarkTheme()
                : AppTheme.getLightTheme();
            break;
        }

        return MaterialApp(
          title: '日历天气',
          theme: themeData,
          darkTheme: AppTheme.getDarkTheme(),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
