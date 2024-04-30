import 'dart:convert';

import 'package:http/http.dart' as http;
import '../open_meteo_api.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApiClient {
  final http.Client _httpClient;
  final _baseUrlGeocoding = 'geocoding-api.open-meteo.com';
  final _baseUrlOpenMeteo = 'api.open-meteo.com';

  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Finds a [Location] `/v1/search/?name=(query)`.
  Future<Location> locationSearch({required query}) async {
    final locationUri =
        Uri.https(_baseUrlGeocoding, '/v1/search', <String, dynamic>{
      "name": query,
      "count": '1',
    });

    final locationResponse = await _httpClient.get(locationUri);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson =
        jsonDecode(locationResponse.body) as Map<String, dynamic>;

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
    final weatherUri =
        Uri.https(_baseUrlOpenMeteo, '/v1/forecast', <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'current_weather': true,
    });
    final weatherResponse = await _httpClient.get(weatherUri);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }
}
