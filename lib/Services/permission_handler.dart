import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionHandler {
  static Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Les services de localisation sont désactivés. Veuillez activer les services.')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Les autorisations de localisation sont refusées')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Les autorisations de localisation sont refusées de manière permanente. Nous ne pouvons pas demander les autorisations.')));
      return false;
    }
    return true;
  }
}
