import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hava_durumu/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  const MainScreen({super.key, required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;
  late String country;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      city = weatherData.city!;
      country = weatherData.country!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            weatherDisplayIcon,
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "$temperature°C",
                style: const TextStyle(
                    fontSize: 65, color: Colors.white, letterSpacing: -5),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                      fontSize: 30, color: Colors.white, letterSpacing: -2),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  country,
                  style: const TextStyle(
                      fontSize: 30, color: Colors.white, letterSpacing: -5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
