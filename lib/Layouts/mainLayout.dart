import 'package:SenYone/Interfaces/ChatBot/chatbot.dart';
import 'package:SenYone/Interfaces/Home/home.dart';
import 'package:SenYone/Interfaces/Line/lines.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          labelStyle: TextStyle(
            fontFamily: 'Red Hat Display',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.3225,
            color: Theme.of(context).primaryColorLight,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Red Hat Display',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.3225,
            color: Theme.of(context).primaryColorLight,
          ),
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).primaryColorDark,
          isScrollable: false,
          tabs: [
            Tab(
              icon: Icon(Icons.moving_outlined),
              text: 'Les lignes',
            ),
            Tab(
              icon: Icon(Icons.home),
              text: 'Accueil',
            ),
            Tab(
              icon: Icon(Icons.message_rounded),
              text: 'Chatbot',
            ),
          ],
        ),
        body: TabBarView(
          
          
          children: [line(), Home(), chatBot()],
        ),
      ),
    );
  }
}
