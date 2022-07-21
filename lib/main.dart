import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_weather_bloc_cubit/bloc/eportingfiles.dart';
import 'package:mock_weather_bloc_cubit/model/weather_repository.dart';
import 'package:mock_weather_bloc_cubit/pages/weather_search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        //create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}
