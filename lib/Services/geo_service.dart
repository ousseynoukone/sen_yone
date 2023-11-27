import 'package:SenYone/Models/Dto/custom_position_dto.dart';
import 'package:SenYone/REST_REQUEST/maps_request.dart';
import 'package:geolocator/geolocator.dart';

class GeoapifyService {
  static Future<CustumPostionDto?> fetchCoordinates(String location) async {
    GeoapifyApi geoApi = new GeoapifyApi();
    final coordinates = await geoApi.getGeocodeCoordinates(location);

    if (coordinates != null) {
      // Handle the retrieved coordinates
      double latitude =
          coordinates['latitude'] ?? 0.0; // Provide a default value if null
      double longitude = coordinates['longitude'] ?? 0.0;


      CustumPostionDto position =
          new CustumPostionDto(latitude: latitude, longitude: longitude);

      return position;
    } else {
      // Handle the case where data retrieval failed
      print('Failed to retrieve coordinates');
      return null; // You might want to return a default value or throw an exception here
    }
  }
}
