import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SenYone/Interfaces/Auth/login.dart';
import 'package:SenYone/Interfaces/ChatBot/chatbot.dart';
import 'package:SenYone/Interfaces/Line/lines.dart';
import '../../Components/components.dart';
import '../../Components/map.dart';
import '../../utils.dart';
import '../../Services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100, // Set your desired height here

            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Déconnexion...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            )),
          ),
        );
      },
    );
  }

  final Box _boxAccount = Hive.box("account_data");
  var isLoading = false;
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => line(),
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
    var username = _boxAccount.get("username");

    logOut() async {
      setState(() {
        isLoading = true;
      });
      var response = AuthService.logOut();
      setState(() {
        isLoading = false;
      });
      if (response.toString().isNotEmpty) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: SafeArea(
            child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  // group340239S2 (210:902)
                  margin:
                      EdgeInsets.fromLTRB(13 * fem, 0 * fem, 12 * fem, 9 * fem),
                  padding:
                      EdgeInsets.fromLTRB(17 * fem, 7 * fem, 21 * fem, 5 * fem),
                  width: double.infinity,
                  height: 34 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  //Bottom bar
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: TextButton(
                          onPressed: () {
                            print("History");
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // historiquevr6 (210:896)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 5 * fem, 1 * fem),
                                  child: Text(
                                    'Historique',
                                    style: SafeGoogleFont(
                                      'Red Hat Display',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3225 * ffem / fem,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                ),
                                Container(
                                  // vectorELz (210:895)
                                  width: 20 * fem,
                                  height: 22 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/vector-daz.png',
                                    width: 20 * fem,
                                    height: 22 * fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _showMyDialog();
                          logOut();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // ousseynoukon9yk (207:654)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5 * fem, 1 * fem),
                                child: Text(
                                  username.length <= 13
                                      ? username
                                      : '${username.substring(0, 10)}...',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3225 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Container(
                                // vectorG2n (207:656)
                                width: 18 * fem,
                                height: 18 * fem,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Image.asset(
                                    'assets/page-1/images/vector-A6v.png',
                                    width: 18 * fem,
                                    height: 18 * fem,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

// body
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorLight, // Background color
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '  Lieu de départ...',
                              hintStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Adjust the space between the two search bars
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorLight, // Background color
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "  Lieu d'arrivé...",
                              hintStyle: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    // autogroupdveav2n (NxMJd4Z2q1LEKwGSa4DVEA)
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.infinity,
                    height: 480,
                    child: MapScreen()),

                Container(
                  // autogroup9sfcXYN (NxMJhE6m1x6MzaXkjG9SfC)
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),

                  width: double.infinity,
                  height: 40,

                  child: TextButton(
                    // group34007Rte (208:741)
                    onPressed: () {
                      print("search traject ! ");
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 175,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff810000),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      // vectorKUE (208:672)

                                      width: 22,
                                      height: 24,
                                      child: Image.asset(
                                        'assets/page-1/images/vector-6HY.png',
                                        width: 22,
                                        height: 24,
                                      ),
                                    ),
                                    Container(
                                      // trouveruntrajetdzi (207:669)

                                      child: Text(
                                        'Trouver un trajet',
                                        style: SafeGoogleFont(
                                          'Red Hat Display',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3225,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),

        // Bottom navigation
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
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
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColorDark,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.moving_outlined), label: 'Les lignes'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Chatbot'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
