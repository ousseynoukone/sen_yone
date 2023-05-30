import 'package:flutter/material.dart';
import '../../Components/components.dart';
import '../../Components/map.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: SearchInputComponent(
                  onPressed: () {},
                )),
            Expanded(
              // Add this Expanded widget
              child: MapScreen(),
            ),
          ],
        ),
      )),
    );
  }
}
