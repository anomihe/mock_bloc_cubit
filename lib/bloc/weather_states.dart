import 'package:equatable/equatable.dart';
import 'package:mock_weather_bloc_cubit/model/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded({required this.weather});

  @override
  List<Object?> get props => [weather];
}

class WeatherErro extends WeatherState {
  final String message;
  const WeatherErro({required this.message});

  @override
  List<Object?> get props => [message];
}
