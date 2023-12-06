import 'package:SenYone/Interfaces/Trajet/trajets_detail.dart';
import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/Models/trajet.dart';

class TrajectComponent extends StatelessWidget {
  final Trajet trajet;

  const TrajectComponent({Key? key, required this.trajet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

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
                                    color: Theme.of(context).primaryColorLight,
                                    fontWeight: FontWeight.w400),
                              ),
                              busNumero(directLine.numero, context),
                            ],
                          ),
                          trajectDetail(directLine, width, context),
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
                          SizedBox(
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
                                  child: busNumero(indirectLineNumero, context),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IndirecttrajectDetail(trajet.indirectLines, width)
                        ],
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ],
    );
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
              RichText(
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
                      text: directLine.busStopD.street,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    )
                  ]))
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
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                      text: "Descendre  à ",
                      children: <TextSpan>[
                    TextSpan(
                      text: directLine.busStopA.street,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    )
                  ]))
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
                  SizedBox(
                    width: width / 1.94,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !directLine.status,
              child: SizedBox(
                width: width / 1.555,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            directTrajetsDetails(directLine: directLine)));
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

  Widget IndirecttrajectDetail(List<IndirectLine> indirectLines, width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width /
              1.6, // Provide a fixed height or use a height based on your needs
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
        Row(
          children: [
            SizedBox(
              width: width / 1.555,
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
                  RichText(
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
                          text: indirectLine.ArretbusD.street,
                        ),
                      ],
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
                  RichText(
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
                          text: indirectLine.ArretbusA.street,
                        ),
                      ],
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
