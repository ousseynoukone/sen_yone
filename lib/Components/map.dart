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
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Scaffold(
        body: FutureBuilder<Position>(
          future: getPosition.determinePosition(), // async work
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else if (snapshot.hasData == false) {
                  print(" does not have data");
                  return Maps(latLng: latLng);
                } else {
                  return Column(children: [
                    SizedBox(
                      width: double.infinity,
                      height: 23 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10 * fem),
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Expanded(
                      child: Maps(
                          latLng: LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude)),
                    ),
                  ]);
                }
            }
          },
        ),
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
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return ClipRRect(
        borderRadius: BorderRadius.circular(10 * fem),
        child: FlutterMap(
          options: MapOptions(
            center: widget.latLng,
            zoom: 17.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: widget.latLng,
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
        ));
  }
}
