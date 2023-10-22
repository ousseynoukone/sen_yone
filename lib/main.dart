import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sen_yone/Interfaces/Auth/login.dart';

import 'Interfaces/Home/start.dart';
import 'Interfaces/Home/home.dart';

void main() async {
  await _initHive();

  runApp(const MyApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  // Here is stored email,password , isLogged  variable
  await Hive.openBox("login");

  //Here is stored username & token data
  await Hive.openBox("account_data");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner

      title: 'SenYone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        primaryColor: Color(0xe5b10000),
        primaryColorDark: const Color.fromARGB(221, 19, 18, 18),
        primaryColorLight: Color.fromARGB(255, 255, 255, 255),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
