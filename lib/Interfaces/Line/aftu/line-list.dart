import 'package:flutter/material.dart';
import 'package:SenYone/utils.dart';

class LineList extends StatefulWidget {
  const LineList({Key? key}) : super(key: key);

  @override
  State<LineList> createState() => _LineListState();
}

class _LineListState extends State<LineList> {
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
      width: double.infinity,
      height: 30 * fem, // Adjust the height as needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            width: 10 * fem,
            height: 10 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5 * fem),
              color: Color(0xffb10000),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
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
