import 'package:SenYone/Interfaces/Line/aftu/details-line/detail-line.dart';
import 'package:SenYone/Interfaces/Line/aftu/tarifs.dart';
import 'package:SenYone/Interfaces/Trajet/tarifs_detail.dart';
import 'package:SenYone/Models/ligne.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/utils.dart';

class CheckPointListe extends StatefulWidget {
  final Ligne ligne;
  const CheckPointListe({Key? key, required this.ligne}) : super(key: key);

  @override
  State<CheckPointListe> createState() => _CheckPointListeState();
}

class _CheckPointListeState extends State<CheckPointListe> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ligne " + widget.ligne.numero.toString()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // depart
          Container(
            width: double.infinity,
            height: 53,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  'Depart ' +
                      (widget.ligne.check_points.firstOrNull.length > 50
                          ? '${widget.ligne.check_points.firstOrNull.substring(0, 47)}...'
                          : widget.ligne.check_points.firstOrNull ?? ''),
                  style: TextStyle(
                    fontFamily: 'Red Hat Display',
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 1.3225,
                    color: Theme.of(context).primaryColorLight,
                  ),
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
                  // Iterate over checkpoints and create CheckpointItem for each
                  for (int i = 1; i < widget.ligne.check_points.length - 1; i++)
                    CheckpointItem(
                      checkPoint: widget.ligne.check_points[i],
                      width: width,
                      scaleFactor: scaleFactor,
                    ),
                ],
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 53,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  'Arrivé ' + (widget.ligne.check_points.lastOrNull),
                  style: TextStyle(
                    fontFamily: 'Red Hat Display',
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 1.3225,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            width: double.infinity,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailLine(ligne: widget.ligne),
                  ),
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 175,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 1),
                            child: Text(
                              'Visualiser',
                              style: SafeGoogleFont(
                                'Red Hat Display',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.3225,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            width: 22,
                            height: 24,
                            child: Image.asset(
                              'assets/page-1/images/vector-7zS.png',
                              width: 22,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            width: double.infinity,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TarifView(
                    tarifs: widget.ligne.tarifs.cast<String>(),
                  ),
                ));
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: Text(
                        'Tarifs',
                        style: SafeGoogleFont(
                          'Red Hat Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.3225,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      width: 22,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/vector-1Tx.png',
                        width: 22,
                        height: 24,
                      ),
                    ),
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
  final String checkPoint;
  final double width;
  final double scaleFactor;

  CheckpointItem(
      {required this.checkPoint,
      required this.scaleFactor,
      required this.width});

  @override
  Widget build(BuildContext context) {
    // Truncate the string to 50 characters and add "..." if it exceeds

    print(width);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 1),
      width: double.infinity,
      height: 40, // Adjust the height as needed
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0.033 * width),
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
                    checkPoint,
                    style: TextStyle(
                      fontFamily: 'Red Hat Display',
                      fontSize: 14 * scaleFactor,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Set the overflow property
                    maxLines: 1, // Specify the maximum number of lines
                  ),
                  Container(
                    height: 1, // Adjust the height as needed
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
