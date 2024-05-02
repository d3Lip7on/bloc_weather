import 'package:bloc_wheather/weather/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_state.g.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
final class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits temperatureUnits;

  WeatherState(
      {this.temperatureUnits = TemperatureUnits.celsius,
      this.status = WeatherStatus.initial,
      Weather? weather})
      : weather = weather ?? Weather.empty;

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  WeatherState copyWith(
      {WeatherStatus? status,
      Weather? weather,
      TemperatureUnits? temperatureUnits}) {
    return WeatherState(
        status: status ?? this.status,
        temperatureUnits: temperatureUnits ?? this.temperatureUnits,
        weather: weather ?? this.weather);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
