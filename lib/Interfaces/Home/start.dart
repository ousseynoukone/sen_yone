import 'dart:convert';

import 'package:SenYone/Layouts/mainLayout.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SenYone/Interfaces/Auth/login.dart';
import '../../Models/Dto/user_dto.dart';
import '../../Services/auth_service.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccount = Hive.box("account_data");
  var isLogin = false;
  var isAnyError = false;
  String email = "";
  String password = "";
  @override
  void initState() {
    super.initState();
    if (_boxLogin.get("loginStatus") ?? false) {
      login();
    }
  }

  login() async {
    setState(() {
      isLogin = true;
    });

    email = _boxLogin.get("login");
    password = _boxLogin.get("password");

    UserDtoLogin u = UserDtoLogin(email: email, password: password);

    var response = await AuthService.login(u);

    if (response != null) {
      setState(() {
        isLogin = false;
      });

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        _boxAccount.put("username", responseJson['username']);
        _boxAccount.put("token", responseJson['token']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainLayout(),
          ),
        );
      }
      if (response.statusCode == 401) {
        setState(() {
          isAnyError = true;
        });
      }

      return response.body;
    }

    // Handle other response statuses or errors here
    return response.statusCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'assets/imgs/transport1.jpg',
              width: 300.0,
              height: 300.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "SenYone",
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // CircularProgressIndicator(color: Theme.of(context).primaryColorLight),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: isLogin
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isLogin
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColorLight)
                : const Text(
                    "Allons-y",
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            isAnyError ? "Votre compte est ou a été désactivée" : "",
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          )
        ],
      )),
    );
  }
}
