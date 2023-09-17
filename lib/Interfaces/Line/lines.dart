import 'package:flutter/material.dart';
import 'package:sen_yone/Interfaces/ChatBot/chatbot.dart';
import 'package:sen_yone/Interfaces/Home/home.dart';

class line extends StatefulWidget {
  const line({super.key});

  @override
  State<line> createState() => _lineState();
}

class _lineState extends State<line> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } else if (index == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => chatBot()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              " Réseau des bus ",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                // Use Noto Serif without custom setup
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor),
        body: SafeArea(
            child: Container(
                child: Center(
                    child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                print("cckled");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AFTU",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 17,
                        // Use Noto Serif without custom setup
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    // Add an Image widget here
                    Image.asset(
                      'assets/imgs/AFTU.jpg',
                      width: 290,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("hello");
                // Handle the tap action here
                // You can navigate to another screen or perform any other action.
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "DAKAR DEM DIKK",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 17,
                        // Use Noto Serif without custom setup
                      ),
                    ),

                    SizedBox(
                      height: 7,
                    ),

                    // Add an Image widget here
                    Image.asset(
                      'assets/imgs/DDD.jpg',
                      width: 290,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )))),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColorDark,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.remove_red_eye_rounded), label: 'Les lignes'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Chatbot'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
