import 'package:flutter/material.dart';
import 'package:SenYone/utils.dart';

class CheckPointListe extends StatefulWidget {
  const CheckPointListe({Key? key}) : super(key: key);

  @override
  State<CheckPointListe> createState() => _CheckPointListeState();
}

class _CheckPointListeState extends State<CheckPointListe> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ligne 25"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // depart
          Container(
            width: double.infinity,
            height: 53 * fem,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Depart Terminus Parcelles Assainies',
                style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.3225 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // checkpoint
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckpointItem('Terminus Parcelles Assainies', fem, ffem),
                  CheckpointItem('Acapes', fem, ffem),
                  CheckpointItem('Dakar plateau', fem, ffem),
                  CheckpointItem('Dakar plateau', fem, ffem),
                  // Add more CheckpointItem widgets with different text as needed
                ],
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 53 * fem,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Arrivé Terminus Parcelles Assainies',
                style: TextStyle(
                  fontFamily: 'Red Hat Display',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.3225 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

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
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color(0xff810000),
                          borderRadius: BorderRadius.circular(10 * fem),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // trouveruntrajetdzi (207:669)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  'Visualiser',
                                  style: SafeGoogleFont(
                                    'Red Hat Display',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3225 * ffem / fem,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                // vectorKUE (208:672)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                width: 22 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/vector-7zS.png',
                                  width: 22 * fem,
                                  height: 24 * fem,
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
    );
  }
}

class CheckpointItem extends StatelessWidget {
  final String text;
  final double fem;
  final double ffem;

  CheckpointItem(this.text, this.fem, this.ffem);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      height: 30 * fem, // Adjust the height as needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.fromLTRB(0, 0, 5, 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xffb10000),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Red Hat Display',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                  ),
                  Container(
                    height: 1 * fem, // Adjust the height as needed
                    color: Color(0x4c000000), // Separating line color
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
