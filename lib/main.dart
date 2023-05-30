import 'package:flutter/material.dart';

import 'Interfaces/Home/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SenYone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        primaryColor: Colors.red,
        primaryColorDark: const Color.fromARGB(221, 19, 18, 18),
        primaryColorLight: Color.fromARGB(255, 255, 253, 253),
        canvasColor: Color.fromARGB(218, 250, 246, 246),
        useMaterial3: true,
      ),
      home: const Start(),
    );
  }
}
