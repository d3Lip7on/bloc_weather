import 'dart:convert';

// import 'package:http/http.dart' as http;
import '../open_meteo_api.dart';
import 'package:dio/dio.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApiClient {
  final Dio _dio;

  final _geocodingPath = 'https://geocoding-api.open-meteo.com/v1/search';
  final _openMeteoPath = 'https://api.open-meteo.com/v1/forecast';

  OpenMeteoApiClient({Dio? dio}) : _dio = dio ?? Dio();

  /// Finds a [Location] `/v1/search/?name=(query)`.
  Future<Location> locationSearch({required query}) async {
    final locationResponse =
        await _dio.get(_geocodingPath, queryParameters: <String, dynamic>{
      "name": query,
      "count": '1',
    });

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }
    final locationJson = locationResponse.data as Map<String, dynamic>;

    if (!locationJson.containsKey('results')) {
      throw LocationNotFoundFailure();
    }

    final results = locationJson['results'];
    if (results.isEmpty) {
      throw LocationNotFoundFailure();
    }

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  // https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true
  Future<Weather> getWeather(
      {required double latitude, required double longitude}) async {
    final weatherResponse =
        await _dio.get(_openMeteoPath, queryParameters: <String, dynamic>{
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = weatherResponse.data as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }
}
