import 'package:SenYone/Components/map.dart';
import 'package:SenYone/Components/map_polylines.dart';
import 'package:SenYone/Models/ligne.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class DetailLine extends StatefulWidget {
  final Ligne ligne;

  const DetailLine({super.key, required this.ligne});

  @override
  State<DetailLine> createState() => _DetailLineState();
}

class _DetailLineState extends State<DetailLine> {
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    polylineCoordinates = _createLatLngList(widget.ligne.itineraire);
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
    double height = MediaQuery.of(context).size.height;
    double scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ligne " + widget.ligne.numero.toString()),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
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
                SizedBox(
                  height: 10,
                ),
                Container(
                    // autogroupdveav2n (NxMJd4Z2q1LEKwGSa4DVEA)
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.infinity,
                    height: height * 0.75,
                    child: MapScreenWithPolyline(
                      polylineCoordinates: polylineCoordinates,
                    )),
              ],
            ),
            Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  'Arrivé ' +
                      (widget.ligne.check_points.lastOrNull.length > 50
                          ? '${widget.ligne.check_points.lastOrNull.substring(0, 47)}...'
                          : widget.ligne.check_points.lastOrNull ?? ''),
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
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
