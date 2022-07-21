import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Weather extends Equatable {
  final String cityName;
  final double temperaturCelsius;
  late double tepmFehrenheit;
  Weather({
    required this.cityName,
    required this.temperaturCelsius,
    required this.tepmFehrenheit,
  });

  @override
  List<Object> get props => [
        cityName,
        temperaturCelsius,
        tepmFehrenheit,
      ];
}
