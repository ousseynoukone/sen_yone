import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import '../Components/map_request/map_get_current_position.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LatLng latLng = LatLng(14.7645042, -17.3660286);

  @override
  void initState() {
    super.initState();
    //_fetchCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder<Position>(
        future: getPosition.determinePosition(), // async work
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return noLocationError(snapshot.error);
              else if (snapshot.hasData == false) {
                print(" does not have data");
                return Maps(latLng: latLng);
              } else {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    width: double.infinity,
                    height: 23,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Maps(
                        latLng: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude)),
                  ),
                ]);
              }
          }
        },
      ),
    );
  }
}

class Maps extends StatefulWidget {
  final LatLng latLng;
  const Maps({required this.latLng});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final _locationStreamController = StreamController<LocationMarkerPosition>();
  final _headingStreamController = StreamController<LocationMarkerHeading?>();

  late Stream<LocationMarkerPosition> _locationStream;
  late Stream<LocationMarkerHeading?> _headingStream;
  late MapController _mapController = MapController();
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

    return ClipRRect(
        borderRadius: BorderRadius.circular(10 * fem),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            enableMultiFingerGestureRace: true,
            center: widget.latLng,
            zoom: 17.2,
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
        ));
  }
}

Widget noLocationError(errorMessage) {
  return Card(
    margin: EdgeInsets.all(16.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.location_off,
            color: Colors.red,
            size: 50.0,
          ),
          SizedBox(height: 16.0),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            " Impossible d\'accéder à votre position. Veuillez vérifier les paramètres de localisation de votre appareil pour utiliser cette fonctionalité.",
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
