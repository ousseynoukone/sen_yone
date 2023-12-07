import 'package:SenYone/Components/map_polylines_direct_trajet.dart';
import 'package:SenYone/Interfaces/Trajet/tarifs_detail.dart';
import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/trajet.dart';
import 'package:SenYone/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class directTrajetsDetails extends StatefulWidget {
  final DirectLine directLine;
  const directTrajetsDetails({super.key, required this.directLine});

  @override
  State<directTrajetsDetails> createState() => _directTrajetsDetailsState();
}

class _directTrajetsDetailsState extends State<directTrajetsDetails> {
  List<LatLng> polylineCoordinates = [];
  late LatLng departPoint;
  late LatLng arrivePoint;
  late LatLng busStopArrive;
  late LatLng busStopDepart;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    polylineCoordinates = _createLatLngList(widget.directLine.line);
    departPoint = new LatLng(
        widget.directLine.startingPoint[0], widget.directLine.startingPoint[1]);
    arrivePoint = new LatLng(
        widget.directLine.endingPoint[0], widget.directLine.endingPoint[1]);

    busStopArrive = new LatLng(widget.directLine.busStopA.coordinates.lat,
        widget.directLine.busStopA.coordinates.lon);

    busStopDepart = new LatLng(widget.directLine.busStopD.coordinates.lat,
        widget.directLine.busStopD.coordinates.lon);
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
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: _height / 1.80,
            child: MapScreenWithPolylineDirectTrajet(
              polylineCoordinates: polylineCoordinates,
              departMarker: departPoint,
              arriveMarker: arrivePoint,
              busStopArrive: busStopArrive,
              busStopDepart: busStopDepart,
            ),
          ),
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
                      return trajectDetail(widget.directLine, width, context);
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
              Container(
                width: width / 1.4,
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
                            text: directLine.busStopD.street,
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
              Container(
                width: width / 1.4,
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
                            text: directLine.busStopA.street,
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3225,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TarifsViewer(
                            tarifs: directLine.tarifs,
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
                            fontSize: 15,
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
                    width: width / 3.4,
                  ),
                ],
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
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Sauvegarder",
                            style: TextStyle(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
