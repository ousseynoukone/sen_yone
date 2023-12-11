import 'package:SenYone/Models/Dto/globals_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../Components/map_request/map_get_current_position.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'dart:async';

import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapScreenWithPolylineDirectTrajet extends StatefulWidget {
  final List<LatLng> polylineCoordinates;
  final LatLng departMarker;
  final LatLng arriveMarker;
  final LatLng busStopArrive;
  final LatLng busStopDepart;
  final RouteInfo routeInfo;
  final numero;
  const MapScreenWithPolylineDirectTrajet(
      {super.key,
      required this.arriveMarker,
      required this.numero,
      required this.departMarker,
      required this.busStopArrive,
      required this.busStopDepart,
      required this.routeInfo,
      required this.polylineCoordinates});

  @override
  State<MapScreenWithPolylineDirectTrajet> createState() =>
      _MapScreenWithPolylineDirectTrajetState();
}

class _MapScreenWithPolylineDirectTrajetState
    extends State<MapScreenWithPolylineDirectTrajet> {
  LatLng basePosition = LatLng(14.7168734, -17.4443997);

  @override
  void initState() {
    super.initState();
    //_fetchCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                  LegendItem(
                    color: Colors.blue,
                    text: 'Ligne ${widget.numero}',
                  ),
                  LegendItem(
                    icon: Icons.location_pin,
                    iconColor: Color.fromARGB(255, 255, 103, 103),
                    text: 'Point de départ',
                  ),
                  LegendItem(
                    icon: Icons.bus_alert,
                    iconColor: Theme.of(context).primaryColor,
                    text: 'Arret de bus la plus proche',
                  ),
                  LegendItem(
                    icon: Icons.location_pin,
                    iconColor: Colors.blue,
                    text: 'Point d\'arrivé',
                  )
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
          routeInfo: widget.routeInfo,
          departMarker: widget.departMarker,
          arriveMarker: widget.arriveMarker,
          busStopArrive: widget.busStopArrive,
          busStopDepart: widget.busStopDepart,
          latLng: basePosition,
          polylineCoordinates: widget.polylineCoordinates,
        ),
      ),
    ]);
  }
}

class MapsPolyline extends StatefulWidget {
  final LatLng latLng;
  final List<LatLng> polylineCoordinates;
  final LatLng departMarker;
  final LatLng arriveMarker;
  final LatLng busStopArrive;
  final LatLng busStopDepart;
  final RouteInfo routeInfo;

  const MapsPolyline(
      {super.key,
      required this.latLng,
      required this.arriveMarker,
      required this.departMarker,
      required this.busStopArrive,
      required this.busStopDepart,
      required this.routeInfo,
      required this.polylineCoordinates});

  @override
  State<MapsPolyline> createState() => _MapsPolylineState();
}

class _MapsPolylineState extends State<MapsPolyline> {
  final _locationStreamController = StreamController<LocationMarkerPosition>();
  final _headingStreamController = StreamController<LocationMarkerHeading?>();

  late Stream<LocationMarkerPosition> _locationStream;
  late Stream<LocationMarkerHeading?> _headingStream;
  late LatLng latLng;

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  _initLocationTracking() {
    _locationStream = Geolocator.getPositionStream().map((position) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
      });
      return LocationMarkerPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy);
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
    MapController _mapController = MapController();

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
              Polyline(
                points: widget.polylineCoordinates,
                strokeWidth: 3,
                color: Theme.of(context).indicatorColor,
              ),
              Polyline(
                points: widget.routeInfo.coordinates,
                strokeWidth: 3,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: widget
                    .busStopDepart, // Replace with the desired coordinates
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    icon: Icon(
                      Icons
                          .bus_alert_sharp, // Replace with the desired icon (e.g., bus stop icon)
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      // Handle marker tap event (e.g., show a popup with information)
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Bus Stop"),
                            content: Text("This is a bus stop."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Marker(
                point: widget
                    .busStopArrive, // Replace with the desired coordinates
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    icon: Icon(
                      Icons
                          .bus_alert_sharp, // Replace with the desired icon (e.g., bus stop icon)
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      // Handle marker tap event (e.g., show a popup with information)
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Bus Stop"),
                            content: Text("This is a bus stop."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  print("pressed ! ");
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Marker(
                point: widget.departMarker,
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 255, 103, 103),
                    size: 40,
                  ),
                ),
              ),
              Marker(
                point: widget.arriveMarker,
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.blueAccent,
                    size: 40,
                  ),
                ),
              ),
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
                      _mapController.move(latLng, 18.0);
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
