import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../Components/map_request/map_get_current_position.dart';

class MapScreenWithPolyline extends StatefulWidget {
  final List<LatLng> polylineCoordinates;
  const MapScreenWithPolyline({super.key, required this.polylineCoordinates});

  @override
  State<MapScreenWithPolyline> createState() => _MapScreenWithPolylineState();
}

class _MapScreenWithPolylineState extends State<MapScreenWithPolyline> {
  LatLng basePosition = LatLng(14.7168734, -17.4443997);

  //  void _fetchCurrentPosition() async {
  //   try {
  //     Position position = await getPosition.determinePosition();
  //     setState(() {
  //       print(latLng);

  //       latLng = LatLng(position.latitude, position.longitude);
  //       print(latLng);
  //     });
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //_fetchCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        child: MapsPolyline(
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
  const MapsPolyline({required this.latLng, required this.polylineCoordinates});

  @override
  State<MapsPolyline> createState() => _MapsPolylineState();
}

class _MapsPolylineState extends State<MapsPolyline> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10 * fem),
      child: FlutterMap(
        options: MapOptions(
                    enableMultiFingerGestureRace: true,

          center: widget.latLng,
          zoom: 12,
                    maxZoom: 18, // Set the maximum allowed zoom level

        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: widget.polylineCoordinates,
                strokeWidth: 3,
                color: Theme.of(context).indicatorColor,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: widget.polylineCoordinates.first,
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                ),
              ),
              Marker(
                point: widget.polylineCoordinates.last,
                width: 20,
                height: 20,
                builder: (context) => Container(
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Theme.of(context).primaryColor,
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
        ],
      ),
    );
  }
}
