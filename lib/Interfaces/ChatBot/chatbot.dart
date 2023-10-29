import 'package:flutter/material.dart';
import 'package:SenYone/Interfaces/Line/lines.dart';

import '../Home/home.dart';

class chatBot extends StatefulWidget {
  const chatBot({super.key});

  @override
  State<chatBot> createState() => _chatBotState();
}

class _chatBotState extends State<chatBot> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } else if (index == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => line()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back button
          // Other AppBar properties and widgets
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
            fontFamily: 'Red Hat Display',
            fontSize: 14 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.3225 * ffem / fem,
            color: Theme.of(context).primaryColorLight,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Red Hat Display',
            fontSize: 12 * ffem,
            fontWeight: FontWeight.w700,
            height: 1.3225 * ffem / fem,
            color: Theme.of(context).primaryColorLight,
          ),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColorDark,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.route), label: 'Les lignes'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Chatbot'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
