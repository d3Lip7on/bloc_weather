import 'package:flutter/material.dart';

import '../weather/view/weather_page.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}
