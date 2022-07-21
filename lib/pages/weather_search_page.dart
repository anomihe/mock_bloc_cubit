import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_weather_bloc_cubit/bloc/eportingfiles.dart';
import 'package:mock_weather_bloc_cubit/model/weather.dart';
import 'package:mock_weather_bloc_cubit/pages/weather_detail_page.dart';

import '../bloc/eportingfiles.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherErro) {
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weather);
              } else if (state is WeatherErro) {
                return buildInitialInput();
              } else {
                // (state is WeatherError)
                return buildInitialInput();
              }
            },
          ),
        ),
      ),
    );
  }

  // more code here...
  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
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
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<WeatherBloc>(context),
                      child: WeatherDetailPage(
                        masterWeather: weather,
                      ),
                    )));
          },
          child: const Text(
            'SeeSetails',
          ),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
          onSubmitted: (value) => submitCityName(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              hintText: "Enter a city",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffix: const Icon(Icons.search))),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    // ignore: todo
    //TODO:fetch the weather from the repository

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName: cityName));
  }
}
