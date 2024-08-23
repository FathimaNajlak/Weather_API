import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_api/consts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherFactory _wf = WeatherFactory(openWeatherApiKey);

  Weather? _weather;
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName('New Delhi').then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 106, 126),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          const SizedBox(height: 10),
          _dateTimeInfo(),
          const SizedBox(height: 20),
          _weatherIcon(),
          const SizedBox(height: 20),
          _currentTemp(),
          const SizedBox(height: 20),
          Flexible(child: _extraInfo()),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? '',
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white));
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat('h:mm a').format(now),
          style: const TextStyle(fontSize: 50, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE').format(now),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat("d.m.y").format(now),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'))),
        ),
        Text(
          _weather?.weatherDescription ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      '${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 124, 183, 204),
            borderRadius: BorderRadius.circular(
              20,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    'Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 87, 108),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  width: 18,
                ),
                Text(
                    'Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 87, 108),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 87, 108),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  width: 18,
                ),
                Text('Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 87, 108),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
