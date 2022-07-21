import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_weather_bloc_cubit/bloc/weather_bloc.dart';
import 'package:mock_weather_bloc_cubit/bloc/weather_states.dart';
import 'package:mock_weather_bloc_cubit/model/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(
    this.weatherRepository,
  ) : super(const WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather: weather));
      } on NetworkError {
        emit(const WeatherErro(message: 'no dta found is your device online'));
      }
    });
    on<GetDetailedWeather>((event, emit) async {
      try {
        final weather =
            await weatherRepository.fetchDetailWeather(event.cityName);
        emit(WeatherLoaded(weather: weather));
      } on NetworkError {
        emit(const WeatherErro(message: 'no data found is your device online'));
      }
    });
  }
}
