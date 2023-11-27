import 'package:SenYone/Models/Dto/custom_position_dto.dart';
import '../../Shared/globals.dart' as globals;
import 'package:geolocator/geolocator.dart';

class getPosition {
// / Determine the current position of the device.
// /
// / When the location services are not enabled or permissions
// / are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Les services de localisation sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Les autorisations de localisation sont refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander les autorisations.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position =await Geolocator.getCurrentPosition();
   globals.userLocation= new CustumPostionDto(latitude: position.latitude, longitude: position.longitude);

    return position;
  }
}
