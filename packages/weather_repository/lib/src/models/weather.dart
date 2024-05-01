import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherCondition { clear, rainy, cloudy, snowy, unknown }

@JsonSerializable()
class Weather extends Equatable {
  final String location;
  final double temperature;
  final WeatherCondition condition;

  const Weather(
      {required this.temperature,
      required this.condition,
      required this.location});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [location, condition, temperature];
}
