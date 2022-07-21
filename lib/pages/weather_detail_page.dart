import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_weather_bloc_cubit/bloc/eportingfiles.dart';
import 'package:mock_weather_bloc_cubit/model/weather.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather masterWeather;
  const WeatherDetailPage({Key? key, required this.masterWeather})
      : super(key: key);

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<WeatherBloc>(context)
        .add(GetDetailedWeather(cityName: widget.masterWeather.cityName));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Detail"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(context, state.weather);
          }
          return Container();
        }),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${weather.temperaturCelsius.toStringAsFixed(1)} C",
          style: const TextStyle(
            fontSize: 80,
          ),
        ),
      ],
    );
  }
}
