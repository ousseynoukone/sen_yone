import 'package:flutter/material.dart';
import 'package:sen_yone/Interfaces/ChatBot/chatbot.dart';
import 'package:sen_yone/Interfaces/Home/home.dart';
import 'package:sen_yone/Interfaces/Line/aftu/line-list.dart';

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
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                " Réseau des bus ",
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0, // Remove the appbar shadow
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 7,
                ),
                Container(
                    child: Center(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LineList()));
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
                              height: 251,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    InkWell(
                      onTap: () {},
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
                )))
              ],
            ),
          ),
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
