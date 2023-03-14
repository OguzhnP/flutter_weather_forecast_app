import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu/screens/main_screen.dart';
import 'package:hava_durumu/utils/location.dart';
import 'package:hava_durumu/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    print("latitude  :${locationData.latitude}");
    print("long  :${locationData.longitude}");
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API den sıcaklık veya durum bilgisi boş dönüyor.");
    }

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 150,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
