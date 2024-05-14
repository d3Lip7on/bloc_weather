import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable(explicitToJson: true)
class Temperature extends Equatable {
  final double value;
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}

@JsonSerializable(explicitToJson: true)
class Weather extends Equatable {
  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final Temperature temperature;

  const Weather(
      {required this.temperature,
      required this.condition,
      required this.location,
      required this.lastUpdated});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
        temperature: Temperature(value: weather.temperature),
        condition: weather.condition,
        location: weather.location,
        lastUpdated: DateTime.now());
  }

  static final empty = Weather(
      temperature: Temperature(value: 0),
      condition: WeatherCondition.unknown,
      location: '--',
      lastUpdated: DateTime(0));

  Weather copyWith(
      {WeatherCondition? condition,
      DateTime? lastUpdated,
      String? location,
      Temperature? temperature}) {
    return Weather(
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [temperature, condition, location, lastUpdated];
}
