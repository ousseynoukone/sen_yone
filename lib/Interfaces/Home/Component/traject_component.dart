import 'package:SenYone/Interfaces/Trajet/trajets_detail.dart';
import 'package:SenYone/Interfaces/Trajet/trajets_detail_indirectTrajet.dart';
import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/trajet_history_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';
import 'package:SenYone/Responsiveness/responsive.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/Models/trajet.dart';
import 'package:logger/logger.dart';

class TrajectComponent extends StatelessWidget {
  final Trajet trajet;

  const TrajectComponent({Key? key, required this.trajet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;
    print(width);
    if (trajet.directLines.isNotEmpty || trajet.indirectLines.isNotEmpty) {
      return Column(
        children: [
          Column(
            children: [
              if (trajet.directLines.isNotEmpty)
                Column(
                  children: trajet.directLines.map((directLine) {
                    return Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Trajet direct : ",
                                  style: TextStyle(
                                      fontSize: 13 * scaleFactor,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.w400),
                                ),
                                busNumero(directLine.numero, context),
                              ],
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double width = constraints.maxWidth;

                                // Assuming trajectDetail is a function that takes directLine, width, and context as parameters
                                return trajectDetail(
                                    directLine, width, context);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

              //indirecte traject
              SizedBox(
                height: 20,
              ),
              if (trajet.indirectLines.isNotEmpty)
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Trajet indirect : ",
                              style: TextStyle(
                                  fontSize: 13 * scaleFactor,
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.w400),
                            ),
                            LayoutBuilder(builder: (context, constraints) {
                              double width = constraints.maxWidth;
                              double height = constraints.maxHeight;
                              return SizedBox(
                                height: 31,
                                width: 210,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: trajet.indirectLines.length,
                                  itemBuilder: (context, index) {
                                    var indirectLineNumero =
                                        trajet.indirectLines[index].numero;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: busNumero(
                                          indirectLineNumero, context),
                                    );
                                  },
                                ),
                              );
                            })
                          ],
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          double width = constraints.maxWidth;
                          double height = constraints.maxHeight;
                          return Row(
                            children: [
                              IndirecttrajectDetail(
                                  trajet.indirectLines, width, context)
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "😞",
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: scaleFactor * 40,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text("Oups ,nous avons trouvé aucun trajet.",
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: scaleFactor * 16,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      );
    }
  }

  Widget busNumero(numero, context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                numero.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 21,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              width: 22,
              height: 24,
              child: Image.asset(
                'assets/page-1/images/vector-Bkv.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget trajectDetail(DirectLine directLine, width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Départ          : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(
                width: width /
                    1.5, // Set a fixed width or use constraints to control overflow
                child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffffffff),
                    ),
                    text: "Prendre le ",
                    children: <TextSpan>[
                      TextSpan(
                        text: directLine.numero.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      ),
                      TextSpan(
                        text: " à ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                      ),
                      TextSpan(
                        text: directLine.startingPointName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Arrivé           : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(
                width: width / 1.5,
                child: RichText(
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                        text: "Descendre  à ",
                        children: <TextSpan>[
                          TextSpan(
                            text: directLine.endingPointName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          )
                        ])),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Fréquence   : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                'Tout les 5 à 15mn',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Distance      : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                '${double.parse((directLine.distance).toStringAsFixed(2))} KM',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Visibility(
              visible: directLine.status,
              child: Row(
                children: [
                  SizedBox(
                    width: 19,
                    height: 21,
                    child: Image.asset(
                      'assets/page-1/images/vector-g3C.png',
                      width: 19,
                      height: 21,
                    ),
                  ),
                  Text(
                    'Moins long',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Responsive(
                      mobile: SizedBox(
                        width: width / 2.5,
                      ),
                      tablet: SizedBox(
                        width: width / 1.5,
                      ),
                      desktop: SizedBox(
                        width: width / 0.5,
                      ))
                ],
              ),
            ),
            Responsive(
                mobile: Visibility(
                  visible: !directLine.status,
                  child: SizedBox(
                    width: width / 1.4,
                  ),
                ),
                tablet: Visibility(
                  visible: !directLine.status,
                  child: SizedBox(
                    width: width / 1.2,
                  ),
                ),
                desktop: Visibility(
                  visible: !directLine.status,
                  child: SizedBox(
                    width: width / 0.2,
                  ),
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => directTrajetsDetails(
                            directLine: directLine,
                            trajetDirectDto: TrajetDirectDto(
                                tarifs: directLine.tarifs,
                                line: directLine.line,
                                routeInfo: directLine.routeInfo,
                                distance: directLine.distance,
                                depart: directLine.startingPointName,
                                arrive: directLine.endingPointName,
                                departLat: directLine.startingPoint.first,
                                departLon: directLine.startingPoint.last,
                                arriveLat: directLine.endingPoint.first,
                                arriveLon: directLine.endingPoint.last,
                                frequence: 15,
                                ligneId: directLine.numero.toString()))));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff810000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                      width: 22,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/vector-j22.png',
                        width: 22,
                        height: 24,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Text(
                        'Détail',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Indirect trajet

  Widget IndirecttrajectDetail(
      List<IndirectLine> indirectLines, width, BuildContext context) {
    var ConcatenedNumero =
        indirectLines.map((line) => line.numero.toString()).join("-");
    Logger().w(ConcatenedNumero);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width:
              width, // Provide a fixed height or use a height based on your needs
          child: IndirecttrajectDetailIterating(indirectLines, width),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Fréquence   : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                'Tout les 5 à 15mn',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Distance      : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                '${double.parse((trajet.indirectLinesDistance).toStringAsFixed(2))} KM',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IndirectTrajetsDetails(
                        indirectLines: indirectLines,
                        distance: trajet.indirectLinesDistance,
                        trajetIndirectDto: TrajetIndirectDto(
                            depart: indirectLines.first.startingPointName,
                            arrive: indirectLines.first.endingPointName,
                            lignes: ConcatenedNumero,
                            distance: trajet.indirectLinesDistance),
                      )),
            );
          },
          child: Row(
            children: [
              Responsive(
                mobile: SizedBox(
                  width: width / 1.4,
                ),
                tablet: SizedBox(
                  width: width / 1.2,
                ),
                desktop: SizedBox(
                  width: width / 1.4,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff810000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                      width: 22,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/vector-j22.png',
                        width: 22,
                        height: 24,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Text(
                        'Détail',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget IndirecttrajectDetailIterating(
    List<IndirectLine> indirectLines,
    double width,
  ) {
    return Column(
      children: List.generate(indirectLines.length, (index) {
        var indirectLine = indirectLines[index];
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text(
                    'Départ          : ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Container(
                    width: width / 1.5,
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                        text: "Prendre le ",
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.numero.toString(),
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffffffff),
                            ),
                            text: " à ",
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.startingPointName,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  indirectLines.length - 1 != index
                      ? Text(
                          'Descendre   : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                        )
                      : Text(
                          'Arrivé           : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                        ),
                  Container(
                    width: width / 1.5,
                    child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffffffff),
                        ),
                        text: "Descendre à ",
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.endingPointName,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
