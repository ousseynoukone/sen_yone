import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sen_yone/Interfaces/ChatBot/chatbot.dart';
import 'package:sen_yone/Interfaces/Line/lines.dart';
import '../../Components/components.dart';
import '../../Components/map.dart';
import '../../utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box _boxAccount = Hive.box("account_data");

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group34022ECa (210:894)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 144 * fem, 0 * fem),
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
                                      fontSize: 14 * ffem,
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
                      Container(
                        // ousseynoukon9yk (207:654)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 2 * fem),
                        child: Text(
                          'Ousseynou Koné',
                          style: SafeGoogleFont(
                            'Red Hat Display',
                            fontSize: 13 * ffem,
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
                          onPressed: () {
                            print("logOut");
                          },
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

// body
                Container(
                  // autogroupfltkPt6 (NxMJDf4N64TQbveGAAFLTk)
                  margin:
                      EdgeInsets.fromLTRB(13 * fem, 0 * fem, 12 * fem, 9 * fem),
                  padding: EdgeInsets.fromLTRB(
                      17 * fem, 11 * fem, 12 * fem, 10 * fem),
                  width: double.infinity,
                  height: 68 * fem,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // autogroup23naUee (NxMJNZyBTAHT66nfwP23NA)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 44 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            9 * fem, 13 * fem, 11 * fem, 13 * fem),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(8 * fem),
                        ),
                        child: Container(
                            width: 165,
                            child:
                                // Second search bar

                                TextField(
                              decoration: InputDecoration(
                                hintText: 'Lieu de depart...',
                                hintStyle: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.search,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              onChanged: (value) {},
                            )),
                      ),
                      Container(
                        // autogroupenaeyE2 (NxMJTjVF3cRmshPuB7enae)
                        padding: EdgeInsets.fromLTRB(
                            9 * fem, 13 * fem, 11 * fem, 13 * fem),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(8 * fem),
                        ),
                        child: Container(
                            width: 165,
                            child:
                                // Second search bar

                                TextField(
                              decoration: InputDecoration(
                                hintText: 'Lieu d\'arrivé...',
                                hintStyle: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.search,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              onChanged: (value) {},
                            )),
                      ),
                    ],
                  ),
                ),

                Container(
                    // autogroupdveav2n (NxMJd4Z2q1LEKwGSa4DVEA)
                    margin: EdgeInsets.fromLTRB(
                        13 * fem, 0 * fem, 12 * fem, 0 * fem),
                    width: double.infinity,
                    height: 630 * fem,
                    child: MapScreen()),
                SizedBox(height: 10),

                Container(
                  // autogroup9sfcXYN (NxMJhE6m1x6MzaXkjG9SfC)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 7 * fem),
                  padding: EdgeInsets.fromLTRB(
                      134 * fem, 8 * fem, 123 * fem, 6 * fem),
                  width: double.infinity,
                  height: 53 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xffb10000),
                  ),
                  child: TextButton(
                    // group34007Rte (208:741)
                    onPressed: () {
                      print("search traject ! ");
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 7 * fem, 15 * fem, 8 * fem),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff810000),
                        borderRadius: BorderRadius.circular(10 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vectorKUE (208:672)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 6 * fem, 0 * fem),
                            width: 22 * fem,
                            height: 24 * fem,
                            child: Image.asset(
                              'assets/page-1/images/vector-fnz.png',
                              width: 22 * fem,
                              height: 24 * fem,
                            ),
                          ),
                          Container(
                            // trouveruntrajetdzi (207:669)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 1 * fem, 0 * fem, 0 * fem),
                            child: Text(
                              'Trouver un trajet',
                              style: SafeGoogleFont(
                                'Red Hat Display',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3225 * ffem / fem,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
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
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColorDark,
          type: BottomNavigationBarType.fixed,
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
