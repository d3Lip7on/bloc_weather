// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) => WeatherState(
      temperatureUnits: $enumDecodeNullable(
              _$TemperatureUnitsEnumMap, json['temperatureUnits']) ??
          TemperatureUnits.celsius,
      status: $enumDecodeNullable(_$WeatherStatusEnumMap, json['status']) ??
          WeatherStatus.initial,
      weather: json['weather'] == null
          ? null
          : Weather.fromJson(json['weather'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'weather': instance.weather,
      'temperatureUnits': _$TemperatureUnitsEnumMap[instance.temperatureUnits]!,
    };

const _$TemperatureUnitsEnumMap = {
  TemperatureUnits.fahrenheit: 'fahrenheit',
  TemperatureUnits.celsius: 'celsius',
};

const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};
