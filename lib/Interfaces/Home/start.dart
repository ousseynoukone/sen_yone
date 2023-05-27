import 'package:flutter/material.dart';

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
          ElevatedButton(
            onPressed: () {
              // Add your button click logic here
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context)
                  .primaryColor, 
              backgroundColor:
                  Theme.of(context).primaryColorLight, 
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), 
              ),
            ),
            child: Text(
              "Allons-y",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      )),
    );
  }
}
