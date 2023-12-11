import 'package:SenYone/Components/map_polylines_direct_trajet.dart';
import 'package:SenYone/Components/map_polylines_indirect_trajet.dart';
import 'package:SenYone/Interfaces/Trajet/tarifs_detail.dart';
import 'package:SenYone/Interfaces/Trajet/tarifs_detail_indirectTrajet.dart';
import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';
import 'package:SenYone/Models/trajet.dart';
import 'package:SenYone/Responsiveness/responsive.dart';
import 'package:SenYone/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class IndirectTrajetsDetails extends StatefulWidget {
  final List<IndirectLine> indirectLines;
  final distance;
  const IndirectTrajetsDetails(
      {super.key, required this.indirectLines, required this.distance});

  @override
  State<IndirectTrajetsDetails> createState() => _IndirectTrajetsDetailsState();
}

class _IndirectTrajetsDetailsState extends State<IndirectTrajetsDetails> {
  List<List<LatLng>> polylineCoordinatesList = [];

  final List<List<CoordinatesFromGlobal>> markersCordinate = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    for (var indirectLine in widget.indirectLines) {
      polylineCoordinatesList.add(_createLatLngList(indirectLine.line));
      markersCordinate.add(_createMarkerList(indirectLine));
    }
  }

  List<LatLng> _createLatLngList(List<dynamic> coordinates) {
    List<LatLng> latLngList = [];
    for (var coordinate in coordinates) {
      double latitude = coordinate[0];

      double longitude = coordinate[1];

      latLngList.add(LatLng(latitude, longitude));
    }

    return latLngList;
  }

  List<CoordinatesFromGlobal> _createMarkerList(IndirectLine indirectLine) {
    List<CoordinatesFromGlobal> x = [];

    x.add(new CoordinatesFromGlobal(
        lon: indirectLine.ArretbusA.coordinates.lon,
        lat: indirectLine.ArretbusA.coordinates.lat));
    x.add(new CoordinatesFromGlobal(
        lon: indirectLine.ArretbusD.coordinates.lon,
        lat: indirectLine.ArretbusD.coordinates.lat));

    return x;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Size screenSize = MediaQuery.of(context).size;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: _height / 90),
            height: _height / 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle the back button press
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16.0),
                Text(
                  "Directives du trajet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0 * scaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ///RESPONSIVENESS AREA
          Responsive(
              mobile: SizedBox(
                height: _height / 1.95,
                child: MapScreenWithPolylineIndirectTrajet(
                  polylineCoordinatesList: polylineCoordinatesList,
                  indirectLinesList: widget.indirectLines,
                ),
              ),
              tablet: SizedBox(
                height: _width / 1.4,
                child: MapScreenWithPolylineIndirectTrajet(
                  polylineCoordinatesList: polylineCoordinatesList,
                  indirectLinesList: widget.indirectLines,
                ),
              ),
              desktop: SizedBox(
                height: _width,
                child: MapScreenWithPolylineIndirectTrajet(
                  polylineCoordinatesList: polylineCoordinatesList,
                  indirectLinesList: widget.indirectLines,
                ),
              )),

          /// END RESPONSIVENESS AREA

          Container(
              child: Card(
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double width = constraints.maxWidth;
                      return IndirecttrajectDetail(widget.indirectLines, width,
                          _height, context, scaleFactor);
                    },
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  //Indirect trajet

  Widget IndirecttrajectDetail(List<IndirectLine> indirectLines, width, height,
      BuildContext context, double scalFactor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive(
            mobile: Container(
              child: Text(
                "Faites défiler vers le bas pour plus",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
            tablet: SizedBox(),
            desktop: SizedBox()),
        Responsive(
            mobile: Container(
              width:
                  width, // Provide a fixed height or use a height based on your needs
              height: height / 9,
              child: IndirecttrajectDetailIterating(
                  indirectLines, width, scalFactor),
            ),
            tablet: Container(
              width:
                  width, // Provide a fixed height or use a height based on your needs
              height: height / 6,
              child: IndirecttrajectDetailIterating(
                  indirectLines, width, scalFactor),
            ),
            desktop: Container(
              width:
                  width, // Provide a fixed height or use a height based on your needs
              height: height / 3,
              child: IndirecttrajectDetailIterating(
                  indirectLines, width, scalFactor),
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Fréquence   : ',
                  style: TextStyle(
                    fontSize: 12 * scalFactor,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                'Tout les 5 à 15',
                style: TextStyle(
                  fontSize: 12 * scalFactor,
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
                    fontSize: 12 * scalFactor,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                '${double.parse((widget.distance).toStringAsFixed(2))} KM',
                style: TextStyle(
                  fontSize: 12 * scalFactor,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffffffff),
                ),
              ),
              //RESPONSIVENESS AREA
              // Responsive(
              //     mobile: SizedBox(
              //       width: width / 3.9,
              //     ),
              //     tablet: SizedBox(
              //       width: width / 1.55,
              //     ),
              //     desktop: SizedBox(
              //       width: width / 3.9,
              //     )),

              //END RESPONSIVENESS AREA
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 31.63,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0.37, 6, 0),
                child: Text(
                  'Tarifs              :',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 12 * scalFactor,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IndirectTarifsViewer(
                            indirectLinesList: indirectLines,
                          )));
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Container(
                  width: 125,
                  decoration: BoxDecoration(
                    color: Color(0xff810000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 7, 7, 4.63),
                        child: Text(
                          'Voir détails',
                          style: SafeGoogleFont(
                            'Red Hat Display',
                            fontSize: 12 * scalFactor,
                            fontWeight: FontWeight.w700,
                            height: 1.3225,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/page-1/images/vector-1Tx.png',
                        width: 22,
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             directTrajetsDetails(directLine: directLine)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff810000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text(
                        "Sauvegarder",
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      SizedBox(
                          width: 8), // Adjust spacing between text and icon

                      Icon(
                        Icons.save,
                        color: Theme.of(context).primaryColorLight,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget IndirecttrajectDetailIterating(
      List<IndirectLine> indirectLines, double width, double scalFactor) {
    return ListView(
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
                      fontSize: 12 * scalFactor,
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
                          fontSize: 12 * scalFactor,
                          color: Color(0xffffffff),
                        ),
                        text: "Prendre le ",
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12 * scalFactor,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.numero.toString(),
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12 * scalFactor,
                              color: Color(0xffffffff),
                            ),
                            text: " à ",
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12 * scalFactor,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.ArretbusD.street,
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
                            fontSize: 12 * scalFactor,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                        )
                      : Text(
                          'Arrivé           : ',
                          style: TextStyle(
                            fontSize: 12 * scalFactor,
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
                          fontSize: 12 * scalFactor,
                          color: Color(0xffffffff),
                        ),
                        text: "Descendre à ",
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12 * scalFactor,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                            text: indirectLine.ArretbusA.street,
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
