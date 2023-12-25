import 'package:SenYone/Components/map_polylines_direct_trajet.dart';
import 'package:SenYone/Components/map_polylines_direct_trajet_history.dart';
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
import 'package:intl/intl.dart';

import 'package:SenYone/Shared/globals.dart';
import 'package:logger/logger.dart';

// ignore: camel_case_types
class directTrajetsHistoryDetails extends StatefulWidget {
  final TrajetDirectDto trajetDirectDto;

  const directTrajetsHistoryDetails({
    Key? key,
    required this.trajetDirectDto,
  }) : super(key: key);

  @override
  State<directTrajetsHistoryDetails> createState() =>
      _directTrajetsHistoryDetailsState();
}

class _directTrajetsHistoryDetailsState
    extends State<directTrajetsHistoryDetails> {
  List<LatLng> polylineCoordinates = [];
  late LatLng departPoint;
  late LatLng arrivePoint;
  late RouteInfo routeInfo;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    polylineCoordinates = createLatLngList(widget.trajetDirectDto.line);
    departPoint = new LatLng(
        widget.trajetDirectDto.departLat, widget.trajetDirectDto.departLon);

    arrivePoint = new LatLng(
        widget.trajetDirectDto.arriveLat, widget.trajetDirectDto.arriveLon);

    routeInfo = widget.trajetDirectDto.routeInfo;
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
                child: MapScreenWithPolylineDirectTrajetHistory(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  numero: widget.trajetDirectDto.numero,
                ),
              ),
              tablet: SizedBox(
                height: _width / 1.3,
                child: MapScreenWithPolylineDirectTrajetHistory(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  numero: widget.trajetDirectDto.numero,
                ),
              ),
              desktop: SizedBox(
                height: _width,
                child: MapScreenWithPolylineDirectTrajetHistory(
                  polylineCoordinates: polylineCoordinates,
                  departMarker: departPoint,
                  routeInfo: routeInfo,
                  arriveMarker: arrivePoint,
                  numero: widget.trajetDirectDto.numero,
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
                      return buildDirectTrajetCard(
                          widget.trajetDirectDto, width, context, scaleFactor);
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

  Widget busNumero(numero, context) {
    return Container(
      margin: EdgeInsets.only(left: 4),
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

  Widget buildDirectTrajetCard(
      TrajetDirectDto directTrajet, width, context, scaleFactor) {
    // Placeholder code for displaying direct trajet card
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
                      fontSize: 13,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w900),
                ),
                busNumero(directTrajet.numero, context),
              ],
            ),
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
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      directTrajet.depart.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
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
                      'Arrivé           : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      directTrajet.arrive.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
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
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      "De 5 à ${directTrajet.frequence.toString()} mn",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
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
                      'Distance      : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${double.parse((directTrajet.distance).toStringAsFixed(2))} KM',
                      style: TextStyle(
                        overflow: TextOverflow.visible,
                        fontSize: 15,
                        color: Color(0xffffffff),
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
                      'Date             : ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(directTrajet.createdAt!),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
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
                        fontSize: 12.0 * scaleFactor,
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
                                tarifs: directTrajet.tarifs,
                                numero: directTrajet.numero,
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
                                fontSize: 12.0 * scaleFactor,
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
          ],
        ),
      ),
    );
  }
}
