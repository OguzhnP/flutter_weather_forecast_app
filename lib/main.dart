import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hava_durumu/screens/loading_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hava Durumu',
        theme: ThemeData.dark(),
        home: const LoadingScreen());
  }
}
