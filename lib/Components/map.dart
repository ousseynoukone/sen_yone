import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../Components/map_request/map_get_current_position.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng latLng = LatLng(14.7645042, -17.3660286);

  void getCurrentPosition() async {
    Position position = await getPosition.determinePosition();
    setState(() {
      latLng = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 20,
          automaticallyImplyLeading: false,
          title: Text(''),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                ], // Define your gradient colors
                begin: Alignment.topCenter, // Align to the top center
                end: Alignment.bottomCenter, // Align to the bottom center
              ),
            ),
          ),
        ),
        body: Container(
          child: FlutterMap(
            options: MapOptions(
              center: latLng,
              zoom: 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
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
            ],
          ),
        ),
      ),
    );
  }
}
