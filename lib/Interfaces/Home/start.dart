import 'package:flutter/material.dart';
import 'package:sen_yone/Interfaces/Home/home.dart';

import '../../Components/components.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
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
          Text(
            "SenBus",
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
          Text(
            "Votre destination , Notre préocupation...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          BtnComponent(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
