import 'package:SenYone/Components/map_polylines_direct_trajet.dart';
import 'package:SenYone/Interfaces/Home/Component/modal.dart';
import 'package:SenYone/Interfaces/Trajet/tarifs_detail.dart';
import 'package:SenYone/Models/Dto/direct_trajet_dto.dart';
import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:SenYone/Models/Dto/trajet_history_dto.dart';
import 'package:SenYone/Models/trajet.dart';
import 'package:SenYone/Responsiveness/responsive.dart';
import 'package:SenYone/Services/operations_service.dart';
import 'package:SenYone/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:SenYone/Shared/globals.dart';
import 'package:logger/logger.dart';

class directTrajetsDetails extends StatefulWidget {
  final DirectLine directLine;
  final TrajetDirectDto trajetDirectDto;
  const directTrajetsDetails(
      {super.key, required this.directLine, required this.trajetDirectDto});

  @override
  State<directTrajetsDetails> createState() => _directTrajetsDetailsState();
}

class _directTrajetsDetailsState extends State<directTrajetsDetails> {
  List<LatLng> polylineCoordinates = [];
  late LatLng departPoint;
  late LatLng arrivePoint;
  late LatLng busStopArrive;
  late LatLng busStopDepart;
  late RouteInfo routeInfo;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    polylineCoordinates = createLatLngList(widget.directLine.line);
    departPoint = new LatLng(
        widget.directLine.startingPoint[0], widget.directLine.startingPoint[1]);
    arrivePoint = new LatLng(
        widget.directLine.endingPoint[0], widget.directLine.endingPoint[1]);

    busStopArrive = new LatLng(widget.directLine.busStopA.coordinates.lat,
        widget.directLine.busStopA.coordinates.lon);

    busStopDepart = new LatLng(widget.directLine.busStopD.coordinates.lat,
        widget.directLine.busStopD.coordinates.lon);

    routeInfo = widget.directLine.routeInfo;
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
                height: _width,
                child: MapScreenWithPolylineDirectTrajet(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  busStopArrive: busStopArrive,
                  busStopDepart: busStopDepart,
                  numero: widget.directLine.numero,
                ),
              ),
              tablet: SizedBox(
                height: _width / 1.2,
                child: MapScreenWithPolylineDirectTrajet(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  busStopArrive: busStopArrive,
                  busStopDepart: busStopDepart,
                  numero: widget.directLine.numero,
                ),
              ),
              desktop: SizedBox(
                height: _width,
                child: MapScreenWithPolylineDirectTrajet(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  busStopArrive: busStopArrive,
                  busStopDepart: busStopDepart,
                  numero: widget.directLine.numero,
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
                      return trajectDetail(
                          widget.directLine, width, context, scaleFactor);
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

  Widget trajectDetail(
      DirectLine directLine, width, BuildContext context, double scalfactor) {
    bool saved = true;
    saveHistorique() async {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text("Sauvegarde en cours "),
                SizedBox(width: 8),
                CircularProgressIndicator(),
              ],
            ),
            duration: Duration(milliseconds: 2000),
          ),
        );
        TrajetDirectDto trajetDirectDto = widget.trajetDirectDto;

        if (trajetDirectDto != null) {
          var result = await OpsServices.getOneLineByNum(
              trajetDirectDto.ligneId.toString());

          if (result != null) {
            trajetDirectDto.ligneId = result!.id.toString();
            var response =
                await OpsServices.createDirectTraject(trajetDirectDto);

            if (response.statusCode == 201) {

              if(mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Text("Sauvegarde effectuée ! "),
                      SizedBox(width: 8),
                      Icon(Icons.check,
                          color: Colors.green), // Use a check icon for success
                    ],
                  ),
                  duration: Duration(milliseconds: 2000),
                ),
              );
              }

            } else {
              if(mounted){
                              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Text("Erreur lors de la sauvegarde"),
                      SizedBox(width: 8),
                      Icon(Icons.error,
                          color: Colors.red), // Use an error icon for failure
                    ],
                  ),
                  duration: Duration(milliseconds: 2000),
                ),
              );
              }

            }

            Logger().d(response.statusCode);
          } else {
            if(mounted){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Text("Erreur lors de la sauvegarde"),
                    SizedBox(width: 8),
                    Icon(Icons.error,
                        color: Colors.red), // Use an error icon for failure
                  ],
                ),
                duration: Duration(milliseconds: 2000),
              ),
            );
            }

          }
        }
      } catch (e) {
if (mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Text("Erreur lors de la sauvegarde"),
          SizedBox(width: 8),
          Icon(Icons.error, color: Colors.red),
        ],
      ),
      duration: Duration(milliseconds: 2000),
    ),
  );
}


        Logger().e("Error in saveHistorique: $e");
      }
    }

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
                    fontSize: 12 * scalfactor,
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
                          fontSize: 12 * scalfactor,
                          color: Color(0xffffffff),
                        ),
                        text: "Prendre le ",
                        children: <TextSpan>[
                          TextSpan(
                            text: directLine.numero.toString(),
                            style: TextStyle(
                              fontSize: 12 * scalfactor,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                          TextSpan(
                            text: " à ",
                            style: TextStyle(
                              fontSize: 12 * scalfactor,
                              color: Color(0xffffffff),
                            ),
                          ),
                          TextSpan(
                            text: directLine.startingPointName,
                            style: TextStyle(
                              fontSize: 12 * scalfactor,
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
                    fontSize: 12 * scalfactor,
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
                          fontSize: 12 * scalfactor,
                          color: Color(0xffffffff),
                        ),
                        text: "Descendre  à ",
                        children: <TextSpan>[
                          TextSpan(
                            text: directLine.endingPointName,
                            style: TextStyle(
                              fontSize: 12 * scalfactor,
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
                  'Tarifs             :',
                  style: SafeGoogleFont(
                    'Red Hat Display',
                    fontSize: 12 * scalfactor,
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
                            numero: directLine.numero,
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
                            fontSize: 12 * scalfactor,
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
                    fontSize: 12 * scalfactor,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                'Tout les 5 à 15',
                style: TextStyle(
                  fontSize: 12 * scalfactor,
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
                    fontSize: 12 * scalfactor,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                '${double.parse((directLine.distance).toStringAsFixed(2))} KM',
                style: TextStyle(
                  fontSize: 12 * scalfactor,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: saved,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  // Perform your desired action when the button is tapped
                  // For example, you can call a different function or navigate to another screen.
                  // replace the code below with your desired functionality
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff810000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Perform your desired action when the button is pressed
                          // For example, you can call a different function or navigate to another screen.
                          // replace the code below with your desired functionality
                          saveHistorique();
                          setState(() {
                            saved = true;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              "Sauvegarder", // Change the button text here
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            SizedBox(
                                width:
                                    8), // Adjust spacing between text and icon
                            Icon(
                              Icons.save, // Change the icon here
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
