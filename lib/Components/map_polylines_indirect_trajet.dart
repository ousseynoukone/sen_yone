import 'dart:async';

import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:SenYone/Models/Dto/undirect_trajet_dto.dart';
import 'package:SenYone/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreenWithPolylineIndirectTrajet extends StatefulWidget {
  final List<List<LatLng>> polylineCoordinatesList;
  final List<IndirectLine> indirectLinesList;

  const MapScreenWithPolylineIndirectTrajet({
    Key? key,
    required this.indirectLinesList,
    required this.polylineCoordinatesList,
  }) : super(key: key);

  @override
  State<MapScreenWithPolylineIndirectTrajet> createState() =>
      _MapScreenWithPolylineIndirectTrajetState();
}

class _MapScreenWithPolylineIndirectTrajetState
    extends State<MapScreenWithPolylineIndirectTrajet> {
  LatLng basePosition = LatLng(14.7168734, -17.4443997);
  List<RandomColorDto> polylineColors = [];

  @override
  void initState() {
    super.initState();
    //A chaque bus sa propre couleur
    polylineColors = List.generate(
      widget.indirectLinesList.length,
      (index) => generateRandomColor(widget.indirectLinesList[index].numero),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Légende
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    LegendItem(
                      color: Theme.of(context).primaryColor,
                      text: 'Chemin vers le point de départ',
                    ),
                    for (var color in polylineColors)
                      LegendItem(
                        color: color.color,
                        text: 'Ligne ${color.numero}',
                      ),
                    LegendItem(
                      icon: Icons.location_pin,
                      iconColor: Colors.orange,
                      text: 'Point de départ',
                    ),
                    LegendItem(
                      icon: Icons.bus_alert,
                      iconColor: Colors.green,
                      text: 'Arret de bus la plus proche ',
                    ),
                    LegendItem(
                      icon: Icons.location_pin,
                      iconColor: Colors.green,
                      text: 'Point d\'arrivé final',
                    ),
                  ],
                ),
              ),
            ),
            // Add a fixed right arrow icon outside the SingleChildScrollView
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),

        SizedBox(height: 10),
        Expanded(
          child: MapsPolyline(
            indirectLinesList: widget.indirectLinesList,
            latLng: basePosition,
            polylineCoordinatesList: widget.polylineCoordinatesList,
            polylineColors: polylineColors,
          ),
        ),
      ],
    );
  }
}

class MapsPolyline extends StatefulWidget {
  final LatLng latLng;
  final List<List<LatLng>> polylineCoordinatesList;
  final List<IndirectLine> indirectLinesList;
  final List<RandomColorDto> polylineColors;

  const MapsPolyline({
    Key? key,
    required this.polylineColors,
    required this.latLng,
    required this.indirectLinesList,
    required this.polylineCoordinatesList,
  }) : super(key: key);

  @override
  State<MapsPolyline> createState() => _MapsPolylineState();
}

class _MapsPolylineState extends State<MapsPolyline> {
  final _locationStreamController = StreamController<LocationMarkerPosition>();
  final _headingStreamController = StreamController<LocationMarkerHeading?>();
  MapController _mapController = MapController();
   LatLng? latLng;

  late Stream<LocationMarkerPosition> _locationStream;
  late Stream<LocationMarkerHeading?> _headingStream;

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  _toLatLong(Coordinates coordinates) {
    return LatLng(coordinates.lat, coordinates.lon);
  }

  _initLocationTracking() {
    _locationStream = Geolocator.getPositionStream().map((position) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
      });
      return LocationMarkerPosition(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
      );
    });

    _headingStream = Geolocator.getPositionStream().map((position) {
      return LocationMarkerHeading(
        heading: position.heading ?? 0.0,
        accuracy: position.headingAccuracy ?? (pi * 0.2),
      );
    });

    _headingStreamController.addStream(_headingStream);

    _locationStreamController.addStream(_locationStream);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10 * fem),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: widget.latLng,
          enableMultiFingerGestureRace: true,
          zoom: 11,
          maxZoom: 18, // Set the maximum allowed zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          CurrentLocationLayer(
              //    turnHeadingUpLocationStream: _headingStream,
              positionStream: _locationStreamController.stream,
              style:
                  LocationMarkerStyle(headingSectorColor: Colors.blueAccent)),
          PolylineLayer(
            polylines: [
              for (int index = 0;
                  index < widget.polylineCoordinatesList.length;
                  index++)
                Polyline(
                  points: widget.polylineCoordinatesList[index],
                  strokeWidth: 3,
                  color: widget.polylineColors[index].color,
                ),
              for (IndirectLine indirectLine in widget.indirectLinesList)
                Polyline(
                  points: indirectLine.routeInfo?.coordinates ?? [],
                  strokeWidth: 3,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
          MarkerLayer(
            markers: [
              for (IndirectLine indirectLine in widget.indirectLinesList) ...[
                Marker(
                  point: LatLng(
                    indirectLine.startingPoint.first,
                    indirectLine.startingPoint.last,
                  ),
                  width: 20,
                  height: 20,
                  builder: (context) => Container(
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors
                          .orange, // Choose a color for the starting point
                    ),
                  ),
                ),
                Marker(
                  point: LatLng(
                    indirectLine.endingPoint!.first,
                    indirectLine.endingPoint!.last,
                  ),
                  width: 20,
                  height: 20,
                  builder: (context) => Container(
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_pin,
                      size: 40,
                      color:
                          Colors.green, // Choose a color for the ending point
                    ),
                  ),
                ),
                Marker(
                  point: _toLatLong(indirectLine.ArretbusD.coordinates),
                  width: 20,
                  height: 20,
                  builder: (context) => Container(
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.bus_alert_sharp,
                      color: Colors.green, // Choose a color for ArretbusD
                      size: 40,
                    ),
                  ),
                ),
                Marker(
                  point: _toLatLong(indirectLine.ArretbusA.coordinates),
                  width: 20,
                  height: 20,
                  builder: (context) => Container(
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.bus_alert_sharp,
                      color: Colors.green, // Choose a color for ArretbusA
                      size: 40,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () {},
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end, // Align at the bottom
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    if (latLng != null) {
                      // Center and zoom the map to the latest user location
                      _mapController.move(latLng!, 18.0);
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Add more widgets within the Column if needed
            ],
          ),
        ],
      ),
    );
  }
}
