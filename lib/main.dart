import 'package:SenYone/Interfaces/ChatBot/chatbot.dart';
import 'package:SenYone/Interfaces/Line/aftu/line-liste.dart';
import 'package:SenYone/Layouts/mainLayout.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SenYone/Interfaces/Auth/login.dart';
import 'package:get/get.dart';
import 'dependency_injection.dart';

import 'Interfaces/Home/start.dart';
import 'Interfaces/Home/home.dart';
import 'package:SenYone/Labs/test.dart';

void main() async {
  await _initHive();
  DependencyInjection.init();

  runApp(const MyApp());
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner

      title: 'SenYone',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          primaryColor: hexToColor(
              '#B10000'), // Use the color string with a hash (#) here
          primaryColorDark: const Color.fromARGB(221, 19, 18, 18),
          hintColor: hexToColor('#820000'),
          primaryColorLight: Color.fromARGB(255, 255, 255, 255),
          useMaterial3: true,
          focusColor: hexToColor('#FFD7D7'),
          indicatorColor: Colors.blue),
      home: const Start(),
    );
  }
}
