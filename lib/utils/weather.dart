import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'location.dart';

const apiKey = "write your own weatherAPI key";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({
    required this.weatherIcon,
    required this.weatherImage,
  });
}

class WeatherData {
  LocationHelper locationData;
  WeatherData({
    required this.locationData,
  });

  double? currentTemperature;
  int? currentCondition;
  String? country;
  String? city;

  Future<void> getCurrentTemperature() async {
    var uri = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        country = currentWeather['sys']['country'];
        city = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API den değer gelmiyor!");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.cloud,
            size: 75,
          ),
          weatherImage: const AssetImage("assets/kapali.jpg"));
    } else {
      var now = DateTime.now();
      if (now.hour >= 19 || now.hour < 6) {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.moon,
              size: 75,
            ),
            weatherImage: const AssetImage("assets/gece.jpg"));
      } else {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.sun,
              size: 75,
            ),
            weatherImage: const AssetImage("assets/acik.jpg"));
      }
    }
  }
}
