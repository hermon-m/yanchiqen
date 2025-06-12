import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/calendar_main_screen.dart';
import 'screens/calendar_edit_screen.dart';
import 'screens/calendar_past_today_screen.dart';
import 'screens/calendar_future_screen.dart';
import 'screens/profile_overview.dart';
import 'screens/basic_info_form.dart';
import 'screens/cycle_info_form.dart';
import 'screens/preferences_screen.dart';
import 'screens/health_education_screen.dart';
import 'state/period_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PeriodData(),
      child: const YanchiqenApp(),
    ),
  );
}

class YanchiqenApp extends StatelessWidget {
  const YanchiqenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YanchiQen',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Lato',
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/calendar': (context) => const CalendarMainScreen(),
        '/calendar_edit': (context) => const CalendarEditScreen(),
        // Pass a default date temporarily or handle this dynamically
        '/calendar_past_today': (context) => CalendarPastTodayScreen(
          selectedDate: DateTime.now(), // Default date for testing purposes
        ),
        '/calendar_future': (context) => const CalendarFutureScreen(),
        '/profile': (context) => const ProfileOverview(),
        '/basic_info': (context) => const BasicInfoForm(),
        '/cycle_info': (context) => const CycleInfoForm(),
        '/preferences': (context) => const PreferencesScreen(),
        // Do NOT use const here, HealthEducationScreen is not a const constructor
        '/education': (context) => HealthEducationScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}