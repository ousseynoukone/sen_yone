import 'package:flutter/material.dart';
import 'package:sen_yone/Interfaces/Line/lines.dart';

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
    return Scaffold(
             appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back button
          // Other AppBar properties and widgets
        ),
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
